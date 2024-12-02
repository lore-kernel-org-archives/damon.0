Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB471DB34E;
	Mon,  2 Dec 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162101; cv=none; b=IkkHpFD06zA7rpapIuoqDR1my4zYC6uLsCsp0Go0HYgg4fla95dS37rxDvu29AmekwhDj9UFljwYVLEwlZX4Bh1d6/dQE2GVnVsJz5hLddcN8TPfvNm+hsz7BIojSdNrZgXl7EkpNBg7msRHJnHb15FbXopqF6FjlodkrAsrMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162101; c=relaxed/simple;
	bh=+PH1RGzcKVyFEO5Vvec2/bPhMqMM7G6soVswaZQBcQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IleUN86pwIr+uCrLxJlUgH199qaD830MR42qXdDgxkGwY9dpl31+PfcS5WQvSuOb+dVB4CPxaFUKxad7dpaB2UQ1zk4XTvNB4N4/VDS4RLR0OCv4DskrvSonuBN2Dy0sve07xs+E0VhTKxu3oYJm29SWFNpBuYuLB1FmWkztXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQBWUYNW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQBWUYNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA963C4CED2;
	Mon,  2 Dec 2024 17:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733162101;
	bh=+PH1RGzcKVyFEO5Vvec2/bPhMqMM7G6soVswaZQBcQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQBWUYNWc6H8BO1BosQcqxBEVbvinwAQkFwgTHf8nKHb0vpvNASCago9GjY242thi
	 FnGsenuQG69u++4RhS0MremWrNqk5k75Q1JYDaoqHbmNB4JRnhmc+o7rMavHyJXPAH
	 UUWfTjftMtjOYQ5qFhWztss3qSgj+YhiV5Txmz513nhU5qIaCbVU5R/cZAFLiYr7PD
	 dhxulKuCrGaWBPicwg3/87PYHC/r7lz8HvoA8FUFw5M3ShYRzgqYPl8XmYbyhACpre
	 izBg/tld9i7TVSoNdxMCqym7mRA5u1yn0h1XgoT4u1biUkymQZK53CRmvqWt3c4yLt
	 6V8o6lwJG0dhw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: A guide to DAMON tuning and results interpretation for hot pages
Date: Mon,  2 Dec 2024 09:54:58 -0800
Message-ID: <20241202175459.2005526-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108232536.73843-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 8 Nov 2024 15:25:36 -0800 SeongJae Park <sj@kernel.org> wrote:

> Hello DAMON community,
> 
> 
> One of common issues that I received from DAMON users is that DAMON's
> monitoring results show hot regions much less than expected.  Specifically, the
> users find regions of only zero or low 'nr_accesses' value from the
> DAMON-generated access pattern snapshots.
> 
> In some cases, it turned out the problem can be alleviated by tuning DAMON
> parameters or changing the way to interpret the results.  I'd like to share the
> details and possible future improvements here.
> 
> Note that I'm not saying this is users' tuning fault.  I admit that the real
> root cause of the issue is the poor interface and lack of guides that makes
> correct tuning difficult, and the suboptimality of DAMON's mechanisms.  We will
> continue working on advancing it in long term.  Sharing some of the plans and
> status at the end of this email.
> 
> TL; DR
> ------
> 
> Users show only low or zero nr_accesses regions mainly because they set
> 'aggregation intrval' too short compared to the workload's memory access
> intensiveness.  Please increase the aggregation interval, or treat
> 'nr_accesses' zero regions of short 'age' as hot regions.
> 
> Now let's walk through more details.  The below sections assume you're familiar
> with DAMON's monitoring mechanisms including 'Access Frequency Monitoring',
> 'Regions Based Sampling', 'Adaptive Regions Adjustment', and 'Age Tracking'.
> You should particularly be familiar with terms including 'sampling interval',
> 'aggregation interval', 'nr_accesses', and 'age'.  If you're not familiar with
> those, you can refer to the document
> (https://www.kernel.org/doc/html/next/mm/damon/design.html#monitoring).
[...]
> 
> Tuning Guide
> ------------
> 
> Based on above root cause theories, I suggest to try below tuning guides.
> 
> If you show DAMON is not working well at finding hot pages,
> 
> 1. Ensure your workload is making meaningfully intensive data accesses.
> 2. Gradually increase aggregation interval and show if it makes change.
> 3. Try using 'age' information even if 'nr_accesses' is zero.
> 4. If nothing works, report the problem to sj@kernel.org, damon@lists.linux.dev
>    and/or linux-mm@kvack.org.
> 
> If increasing aggregation interval alleviates your problem, you can further
> consider increasing 'sampling interval'.  If it doesn't harm the quality of the
> access pattern snapshots, having low 'sampling interval' will only increase
> DAMON's CPU usage.
> 
> For using 'age' information of zero 'nr_accesses' regions, different approaches
> could be used for profiling use case and DAMOS use case.  For profiling use
> case, users can try reading recency or access temperature based histograms
> (https://github.com/damonitor/damo/blob/v2.5.4/USAGE.md#access-report-styles)
> of snapshots from record, or live-captured snapshots.
> 
> If the use case is for DAMOS, applying the 'age' information on DAMOS target
> access pattern would be straightforward.  Using DAMOS Quotas together can be
> useful, since it provides its own under-quota-prioritization logic that
> utilizes 'age' information for zero 'nr_accesses' regions, and further provides
> auto-tuning of the quota for given target metric/value.

I tried monitoring the access patterns on the physical address space of a
system running a real-world server workload.  I was able to reproduce the
reported poor quality of hot pages detection using default parameter.  And I
was also able to improve the quality following the above tuning guide.  I'm
sharing the details as an example.

5ms/100ms intervals: Reproduce Problem
--------------------------------------

Initially, I captured the access pattern snapshot on the physical address
space using DAMON, with the default interval parameters (5 milliseconds and 100
milliseconds for the sampling and the aggregation intervals, respectively).  I
wait ten minutes after starting DAMON, to show a meaningful time-wise access
patterns.

```
# damo start
# sleep 600
# damo record --snapshot 0 1
# damo stop
```

Then, I listed the DAMON-found regions of different access patterns, sorted by
the access temperature.  Access temperature is
calculated (https://github.com/damonitor/damo/blob/v2.5.8/src/damo_report_access.py#L643)
as a weighted sum of the access frequency and the age of the region.  If the
access frequency is 0 %, the temperature is multipled by minus one.  That is,
if a region is not accessed, it gets minus temperature and it gets lower as not
accessed for longer time.  The sorting is in temperature-ascendint order, so
the region at the top of the list is the coldest, and the one at the bottom is
the hottest one.

```
# damo report access --sort_regions_by temperature
0   addr 16.052 GiB   size 5.985 GiB   access 0 %   age 5.900 s    # coldest
1   addr 22.037 GiB   size 6.029 GiB   access 0 %   age 5.300 s
2   addr 28.065 GiB   size 6.045 GiB   access 0 %   age 5.200 s
3   addr 10.069 GiB   size 5.983 GiB   access 0 %   age 4.500 s
4   addr 4.000 GiB    size 6.069 GiB   access 0 %   age 4.400 s
5   addr 62.008 GiB   size 3.992 GiB   access 0 %   age 3.700 s
6   addr 56.795 GiB   size 5.213 GiB   access 0 %   age 3.300 s
7   addr 39.393 GiB   size 6.096 GiB   access 0 %   age 2.800 s
8   addr 50.782 GiB   size 6.012 GiB   access 0 %   age 2.800 s
9   addr 34.111 GiB   size 5.282 GiB   access 0 %   age 2.300 s
10  addr 45.489 GiB   size 5.293 GiB   access 0 %   age 1.800 s    # hottest
total size: 62.000 GiB
```

The list shows not seemingly hot regions, and only minimum access pattern
diversity.  Every region has zero access frequency.  The number of region is
10, which is the default `min_nr_regions` value.  Size of each region is also
nearly idential.  We can suspect this is because "adaptive regions adjustment"
mechanism was not well working.  As the guide suggested, we can get relative
hotness of regions using 'age' as the recency information.  That would be
better than nothing, but given the fact that the longest age is only about 6
seconds while we waited about ten minuts, it is unclear how useful this will
be.

The temperature ranges to total size of regions of each range histogram
visualization (https://github.com/damonitor/damo/blob/v2.5.7/USAGE.md#access-report-styles)
of the results also shows no interesting distribution pattern.

```
# damo report access --style temperature-sz-hist
<temperature> <total size>
[-,590,000,000, -,549,000,000) 5.985 GiB  |**********          |
[-,549,000,000, -,508,000,000) 12.074 GiB |********************|
[-,508,000,000, -,467,000,000) 0 B        |                    |
[-,467,000,000, -,426,000,000) 12.052 GiB |********************|
[-,426,000,000, -,385,000,000) 0 B        |                    |
[-,385,000,000, -,344,000,000) 3.992 GiB  |*******             |
[-,344,000,000, -,303,000,000) 5.213 GiB  |*********           |
[-,303,000,000, -,262,000,000) 12.109 GiB |********************|
[-,262,000,000, -,221,000,000) 5.282 GiB  |*********           |
[-,221,000,000, -,180,000,000) 0 B        |                    |
[-,180,000,000, -,139,000,000) 5.293 GiB  |*********           |
total size: 62.000 GiB
```

In short, the result is very similar to the reported problems: poor quality
monitoring results for hot regions detection.  According to the above guide,
this is due to the too short aggregation interval.

100ms/2s intervals: Starts Showing Small Hot Regions
----------------------------------------------------

Following the guide, I increased the interval 20 times (100 milliseocnds and 2
seconds for sampling and aggregation intervals, respectively).

```
# damo start -s 100ms -a 2s
# sleep 600
# damo record --snapshot 0 1
# damo stop
# damo report access --sort_regions_by temperature
0   addr 10.180 GiB   size 6.117 GiB   access 0 %   age 7 m 8 s    # coldest
1   addr 49.275 GiB   size 6.195 GiB   access 0 %   age 6 m 14 s
2   addr 62.421 GiB   size 3.579 GiB   access 0 %   age 6 m 4 s
3   addr 40.154 GiB   size 6.127 GiB   access 0 %   age 5 m 40 s
4   addr 16.296 GiB   size 6.182 GiB   access 0 %   age 5 m 32 s
5   addr 34.254 GiB   size 5.899 GiB   access 0 %   age 5 m 24 s
6   addr 46.281 GiB   size 2.995 GiB   access 0 %   age 5 m 20 s
7   addr 28.420 GiB   size 5.835 GiB   access 0 %   age 5 m 6 s
8   addr 4.000 GiB    size 6.180 GiB   access 0 %   age 4 m 16 s
9   addr 22.478 GiB   size 5.942 GiB   access 0 %   age 3 m 58 s
10  addr 55.470 GiB   size 915.645 MiB access 0 %   age 3 m 6 s
11  addr 56.364 GiB   size 6.056 GiB   access 0 %   age 2 m 8 s
12  addr 56.364 GiB   size 4.000 KiB   access 95 %  age 16 s
13  addr 49.275 GiB   size 4.000 KiB   access 100 % age 8 m 24 s   # hottest
total size: 62.000 GiB
# damo report access --style temperature-sz-hist
<temperature> <total size>
[-42,800,000,000, -33,479,999,000) 22.018 GiB |*****************   |
[-33,479,999,000, -24,159,998,000) 27.090 GiB |********************|
[-24,159,998,000, -14,839,997,000) 6.836 GiB  |******              |
[-14,839,997,000, -5,519,996,000)  6.056 GiB  |*****               |
[-5,519,996,000, 3,800,005,000)    4.000 KiB  |*                   |
[3,800,005,000, 13,120,006,000)    0 B        |                    |
[13,120,006,000, 22,440,007,000)   0 B        |                    |
[22,440,007,000, 31,760,008,000)   0 B        |                    |
[31,760,008,000, 41,080,009,000)   0 B        |                    |
[41,080,009,000, 50,400,010,000)   0 B        |                    |
[50,400,010,000, 59,720,011,000)   4.000 KiB  |*                   |
total size: 62.000 GiB
```

DAMON found two distinct 4 KiB regions that pretty hot.  The regions are also
well aged.  The hottest 4 KiB region was keeping the access frequency for about
8 minutes, and the coldest region was keeping no access for about 7 minutes.
The distribution on the histogram also looks like having a pattern.

Especially, the finding of the 4 KiB regions shows DAMON's adaptive regions
adjustment is working as designed.

Still the number of regions is close to the `min_nr_regions`, and sizes of cold
regions are similar, though.  Apparently it is improved, but it still has rooms
to improve.

400ms/8s intervals: Pretty Improved Results
-------------------------------------------

I further increased the intervals four times (400 milliseconds and 8 seconds
for sampling and aggregation intervals, respectively).

```
# damo start -s 400ms -a 8s
# sleep 600
# damo record --snapshot 0 1
# damo stop
# damo report access --sort_regions_by temperature
0   addr 64.492 GiB   size 1.508 GiB   access 0 %   age 6 m 48 s    # coldest
1   addr 21.749 GiB   size 5.674 GiB   access 0 %   age 6 m 8 s
2   addr 27.422 GiB   size 5.801 GiB   access 0 %   age 6 m
3   addr 49.431 GiB   size 8.675 GiB   access 0 %   age 5 m 28 s
4   addr 33.223 GiB   size 5.645 GiB   access 0 %   age 5 m 12 s
5   addr 58.321 GiB   size 6.170 GiB   access 0 %   age 5 m 4 s
[...]
25  addr 6.615 GiB    size 297.531 MiB access 15 %  age 0 ns
26  addr 9.513 GiB    size 12.000 KiB  access 20 %  age 0 ns
27  addr 9.511 GiB    size 108.000 KiB access 25 %  age 0 ns
28  addr 9.513 GiB    size 20.000 KiB  access 25 %  age 0 ns
29  addr 9.511 GiB    size 12.000 KiB  access 30 %  age 0 ns
30  addr 9.520 GiB    size 4.000 KiB   access 40 %  age 0 ns
[...]
41  addr 9.520 GiB    size 4.000 KiB   access 80 %  age 56 s
42  addr 9.511 GiB    size 12.000 KiB  access 100 % age 6 m 16 s
43  addr 58.321 GiB   size 4.000 KiB   access 100 % age 6 m 24 s
44  addr 9.512 GiB    size 4.000 KiB   access 100 % age 6 m 48 s
45  addr 58.106 GiB   size 4.000 KiB   access 100 % age 6 m 48 s    # hottest
total size: 62.000 GiB
# damo report access --style temperature-sz-hist
<temperature> <total size>
[-40,800,000,000, -32,639,999,000) 21.657 GiB  |********************|
[-32,639,999,000, -24,479,998,000) 17.938 GiB  |*****************   |
[-24,479,998,000, -16,319,997,000) 16.885 GiB  |****************    |
[-16,319,997,000, -8,159,996,000)  586.879 MiB |*                   |
[-8,159,996,000, 5,000)            4.946 GiB   |*****               |
[5,000, 8,160,006,000)             260.000 KiB |*                   |
[8,160,006,000, 16,320,007,000)    0 B         |                    |
[16,320,007,000, 24,480,008,000)   0 B         |                    |
[24,480,008,000, 32,640,009,000)   0 B         |                    |
[32,640,009,000, 40,800,010,000)   16.000 KiB  |*                   |
[40,800,010,000, 48,960,011,000)   8.000 KiB   |*                   |
total size: 62.000 GiB
```

The number of regions having different access patterns has significantly
increased.  Size of each region is also more varied.  Total size of non-zero
access frequency regions is also significantly increased.  Maybe this is
already good enough to make some meaningful memory management efficieny
changes.

800ms/16s intervals: Another bias
---------------------------------

Further doubling the intervals (800 milliseconds and 16 seconds for sampling
and aggregation intervals, respectively) mor improved the hot regions
detection, but starts looking degrading cold regions detection.

```
# damo start -s 800ms -a 16s
# sleep 600
# damo record --snapshot 0 1
# damo stop
# damo report access --sort_regions_by temperature
0   addr 64.781 GiB   size 1.219 GiB   access 0 %   age 4 m 48 s
1   addr 24.505 GiB   size 2.475 GiB   access 0 %   age 4 m 16 s
2   addr 26.980 GiB   size 504.273 MiB access 0 %   age 4 m
3   addr 29.443 GiB   size 2.462 GiB   access 0 %   age 4 m
4   addr 37.264 GiB   size 5.645 GiB   access 0 %   age 4 m
5   addr 31.905 GiB   size 5.359 GiB   access 0 %   age 3 m 44 s
[...]
20  addr 8.711 GiB    size 40.000 KiB  access 5 %   age 2 m 40 s
21  addr 27.473 GiB   size 1.970 GiB   access 5 %   age 4 m
22  addr 48.185 GiB   size 4.625 GiB   access 5 %   age 4 m
23  addr 47.304 GiB   size 902.117 MiB access 10 %  age 4 m
24  addr 8.711 GiB    size 4.000 KiB   access 100 % age 4 m
25  addr 20.793 GiB   size 3.713 GiB   access 5 %   age 4 m 16 s
26  addr 8.773 GiB    size 4.000 KiB   access 100 % age 4 m 16 s
total size: 62.000 GiB
# damo report access --style temperature-sz-hist
<temperature> <total size>
[-28,800,000,000, -23,359,999,000) 12.294 GiB  |*****************   |
[-23,359,999,000, -17,919,998,000) 9.753 GiB   |*************       |
[-17,919,998,000, -12,479,997,000) 15.131 GiB  |********************|
[-12,479,997,000, -7,039,996,000)  0 B         |                    |
[-7,039,996,000, -1,599,995,000)   7.506 GiB   |**********          |
[-1,599,995,000, 3,840,006,000)    6.127 GiB   |*********           |
[3,840,006,000, 9,280,007,000)     0 B         |                    |
[9,280,007,000, 14,720,008,000)    136.000 KiB |*                   |
[14,720,008,000, 20,160,009,000)   40.000 KiB  |*                   |
[20,160,009,000, 25,600,010,000)   11.188 GiB  |***************     |
[25,600,010,000, 31,040,011,000)   4.000 KiB   |*                   |
total size: 62.000 GiB
```

It found more non-zero access frequency regions.  The number of regions is
still much higher than the `min_nr_regions`, but it is reduced from that of the
previous setup.  And apparently the distribution seems bit biased to hot
regions.

Conclusion
----------

Because the workload is live, the above results are not always consistent.
But, the tendency of the quality for the interval changes was consistent.

With the above experimental tuning results, I conclude the theory and the guide
makes sense to at least this workload, and could be applied to similar cases.

This also gives us an idea for automated tuning of the intervals.  If the
interval is too short, results are biased to cold regions.  If the interval is
too long, results are biased to hot regions.  Maybe DAMON can moitor to which
direction the current snapshot is biased, and adjust the intervals.  I will
develop the idea more.


Thanks,
SJ

[...]
