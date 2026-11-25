Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.229.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795644628;
	b=P17AWsc7FaT4qrIW5UrQMLd+JTsgTns3U1veUrpKTQqDHnu5r5jgj/r4qrMTRpjKD+Tu
	 4nVklGhmMbX4P1DCG+m4ASiWvnfxgtA2Euwys65aDkiAa5jYujRAw5IEr2SXGz0qYv/qw
	 +PfiKptUe84RFwgAWMKvC1zo88j7sob8/iyftQbYhC4oMKomH4pO9CXm9ZO0NEZIvV6Pr
	 DehyV0Kqxv83k6RMvWBtiHutgqRbH0w0fL0IL750HwGGItI/CTSIu25uN/yJSE3dMi1PS
	 sR22wYWuP22qNKZKI32+rY4J+U4U7+X2r7XOlPmHOA6TtL0EbLNevBos8jQDXV789YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CkBk2j5ivR/mh7ILFij97SNuJfGxESxh8j6/caNV86A=;
	b=gW220xvR9KMnf8Y0+7tCa+yUlHGPqKWDn0BpBXQQs2hpSL/nJsEWE/JiCC41cjePeEAs
	 OGSMekXIY6VQdEi1ViKQcpQqKpC/8lLq4tCJWswvWCg5FWuszXlWk2JPC4GHDa9kyQ13g
	 4h5EjW3q6H0HPlzLjy6UPgdu0zp1rtV17Ohp5qcCt1TR0e1ufdia/bwee8UkSNz+1y2g4
	 ZXiKEc2gbrsN3d6r6N5+VaqKEK7rxFeq+m1bIkaY1ouV7Q5n7Wrn1ROjBKNqwmyAniKeR
	 rQZnYQrH+1uHubbokn2SttFpxwYcNJEc0TG/zUEbnA1LXoSCj56EJ+iLNMGlAmdGp0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="SeeUY1/x";
	arc=fail smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745C606A323
	for <damon@lists.linux.dev>; Wed, 25 Nov 2026 22:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2745C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SeeUY1/x
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-139b659a45eso694455c88.1
        for <damon@lists.linux.dev>; Wed, 25 Nov 2026 14:10:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795644627; cv=none;
        d=google.com; s=arc-20260327;
        b=gpwR03ZQrvnsX7wKA21qsg7EdjZBDK/X1xsH2WonFRD89T9H2ujGE0BRnrcqg5blRn
         B+JZ/Ens0wlvOl7DOoMVAVWH0ph9+2Ky7ExfDGSQMtN2KLm52IXRGaalBIFZFGNarcxl
         SM77tlvj/nf5ix2IyNw+GY23pGGX/VyDCvxGncaK721tN9TYMvFvetasV9fe2YTtQPQw
         vyqGuJD08FiyVpX34RFBa0yGISScYZWJy8wtYqK6yZ9N8eIWRbkbfT5PlEx+KhMe9GQD
         6fIKFIoaBA7T00ZieFBOI6M8zt6YcQvLKIwWjAf6mp3NjeB/ahRlkqiSV/vW05wpkltr
         p8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CkBk2j5ivR/mh7ILFij97SNuJfGxESxh8j6/caNV86A=;
        fh=JZIiDBvdDdqAUzh7I37tvQieuneaS9CiPTO+c0OrcdQ=;
        b=kKg3Cd+r2dNqqOk/JH4hPr//mj7/64CHM79r1elfdaejECy5JZ6jkcKDvcVgXFoudy
         vRc6ToH48QlSMp8qllv9ag9xKoAcz/tFLxLFwGrLFsNmDw5BWPm29JCwQYHAqDLY1f3w
         nfXVNA62MX0CUxM0hCtzIfZgSQy5dtsvLkrb95Dq10Kz+XZFvWevKeQh9faxz2GhFnvp
         g164AzB0iQBUIuLm8nWMu4mB1JAo+0C8nSErWmufPIqbhy9TpgDSBGWsGHBwf28JqMgf
         7n1TyGGq7TmWiTL+qwqSqZuduWlKAfjNgUvgXn6gfVQR84NJ9JoIHtn2xHbcaEG1DfGR
         ZcAw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795644627; x=1796249427; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CkBk2j5ivR/mh7ILFij97SNuJfGxESxh8j6/caNV86A=;
        b=SeeUY1/xOW+/xxcCMNouyja2k4AfnS8dMdA/PB94JPGARcTC3dwd8/RjE7vARemmKv
         xp0vahZSDP07qgsmNYqNJF7eIgtMZkN1qsG018qVKu7hP3XhjU+mr4520hoUWUidLs6M
         07mxqPs+iubRptvzVuZWryx7c9EbPCc8eP28dmBpiujEJmvfqozQtJNYm7IZQUnHPJg2
         D62yPtlyio5Egng0NlA/CIMsXD+5yajDAmc+LnIwAwn7b2k2zgFfmrn4cEVKLX/AZcNN
         A1rGR7kULKOMsBf9t5LpXlctP4BjNd+X8NagtBUbCqrQXfGG9jtRY4VVG2MyF2ubRMFH
         CK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644627; x=1796249427;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CkBk2j5ivR/mh7ILFij97SNuJfGxESxh8j6/caNV86A=;
        b=QyIBy6ByV/YEaRXq6wngXwDcs33J0D0N4NJRbTrvpK6CRSx6tD9ct2mj6y10AjUfPq
         kLQCg+rEeFXmmSml0sh0pV0/UgUQT6RUMWiCq8nbVHNsC+NMrI81tSWpKUsEwPGUIMXS
         61vOOwy44TRqnwYjWvDDuWkHSyZePzPu2uFsaiweO96mlHgiHsaKAVnwJRTQao7ASEYK
         23xZugu8zMWJMpeIe9O2U7EqRse05N7U8sCrB8Z1TsXCMCelF2qrgVY2zXG8eX3ABPpO
         fR+MURsqUy2cy9i8oGRcHFFqUHI8kWkmaRqsSmPWTNV8JWarokrg0/2Y4V3C5YC6xNkc
         xNpw==
X-Forwarded-Encrypted: i=1; AL+hErE51797OAznwKRpvr+Z1AYzRzbpycBKsDdZsKDQQ9dE87LKHwtzPQZI+yOO3uy+/bA/1Ew4Wg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ReSJleDGlxfYVh1jddwQToi86trh1Eu2cnPNzHQsZSMRYXtuV
	cIJyh2m0o7YUUwgaRHP9an19LDhGBJ5TtqvRKPNWbtAhqC0QWHCV7CVbDMqwg44xQgKYQGRrNWg
	OcEKF4qYm25wIT2GEJXiNYpDOSeBh2A==
X-Gm-Gg: AZFdTZegVibEdv+BOBQksNjnBvBSFoNTpLbFEwg0w2UQ3aShnmzLV2dRrJAXsf2tsNL
	2ahQLMiEWkcPRHeZVJuuxejzglUEY1J/sEtn3Vvy+hv9qL+SE/7Qrtmf3hKvS4/v+IH+ofztCWq
	vhLuxMhO4E67+hCchXzyh2VDIVeXZiF1pI2RWHboi0bu70jDtEdGBKh8OUMQu7W2l1hQdLgKPqs
	BjWGXPMQJqA0RvhoQjneI+R9abCSrmqe22vw74JjTedAvPsQH91BNZvcxqWHugfdXkLOanhkMjA
	45fUkcaxm1h3LnwRzcC0YEtwJcxBYkL6TqKo5tUzScGH6p0oBxK9v1sClAkFDmUm98WMGXAlYAx
	P9/u8kAgGzWBkUtQK+voZp/jLYEeykq3297eS
X-Received: by 2002:a05:701a:8148:10b0:143:2719:f800 with SMTP id
 a92af1059eb24-1b556908ecdmr17988038c88.40.1795644627021; Wed, 25 Nov 2026
 14:10:27 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261124153636.91854-1-sj@kernel.org>
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 25 Nov 2026 14:10:15 -0800
X-Gm-Features: Aa3M54o3hTkahzH_49Bjbc7Zx-dgkzZBTJlliNIgBcED_vBed0zNdkBdD-nvRds
Message-ID: <CALa+Y14BNfdWH3yBY+ky1+Sb0YvRzW=gRcKKyGWWaBQkysPUkA@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] mm/damon: let users report their data attribute findings
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, damon@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi SJ,

I tested v2 as it is in mm-new, and wanted to share what I saw.

How I tested:

The guest is x86_64 with 8 CPUs and 4 GiB of RAM in two NUMA nodes.
A paddr context watches 1 GiB of node 1, the physical range
[4 GiB, 5 GiB).  Every 5 ms DAMON samples an address in each region,
and the context's probes decide whether that sample counts as a hit.
User reports are submitted through the sysfs producer files.

The context has three probes:

- one with a REPORT_MADE filter for user_report, matching=Y, allow=Y:
  it counts the samples that find a report;
- one with the same filter but matching=N: it counts the samples that
  find no report;
- one with no filter: it counts all samples.

For each test I compared the hits of the first two with the number
they should be, as a share of all samples.

I tried four cases:

1. A report that starts exactly at the sampled address, with
   addr_unit 1 and 4096.
2. A report over the whole watched range, kept fresh by one to
   sixteen writers re-submitting it, slowly and then as fast as they
   can.  Every sample should find it.
3. Reports with an empty or inverted range, next to one valid report.
4. A REPORT_MADE filter on a vaddr context instead of paddr.

The DAMON KUnit suites pass.

What I saw

Case 1 works now: with the addr_unit fix in v2, those reports match.
Thanks.

Cases 2 to 4 do not behave as I expected:

2. As the submit rate goes up, two things go wrong:
   - with matching=Y, the probe misses the report more and more
     often, although it is always there;
   - with matching=N, the probe matches more and more often, although
     it should never match.
3. Empty and inverted reports are accepted.  They never match, but
   they take queue slots, and enough of them push the valid report
   out.
4. On a vaddr context the filter is accepted but has no effect.

Where it comes from

Case 2: a busy report queue (13/27, 14/27)

When a lookup finds the report queue locked, for example by a submit,
it answers "not found" rather than "don't know".  For matching=Y that
is a miss; for matching=N it is a match.  The more writers, the busier
the queue, and the more samples go wrong.

The right answer here is 100 % of samples for matching=Y and 0 % for
matching=N.  What I measured (the last column is the share of submits
refused as busy):

  writers               matching=Y   matching=N   refused submits
  1, one submit per ms     99.5 %        0.5 %          0.1 %
  1, back to back          45.5 %       55.3 %          0.2 %
  4, back to back          49.0 %       51.3 %         60.2 %
  16, back to back         15.6 %       84.9 %         79.9 %

The numbers vary somewhat between boots; the trend does not.

Could a lookup that finds the queue busy skip that sample instead of
counting it as a miss?

Cases 3 and 4: input checks

Two smaller things, both about inputs that are accepted but cannot
work:

- Submit accepts a report whose start equals its end, or is above it
  (22/27, 23/27).  It never matches but takes a queue slot: with 1000
  of them after a valid report, the valid one is found in only 4 % of
  samples.  Return -EINVAL for these?
- A vaddr context accepts a REPORT_MADE filter (16/27), but the vaddr
  operations never evaluate it.  Refuse it for non-paddr contexts for
  now?

A minor nit in the cover letter: the loop
"echo submit > producer_state" runs in producers/, so it fails with
"Permission denied".  It should be "echo submit > 0/producer_state".

Thanks,
Ravi

---
The case 2 setup, for reference (paddr, node 1 = [4 GiB, 5 GiB)):

  A=/sys/kernel/mm/damon/admin
  C=$A/kdamonds/0/contexts/0
  echo 1 > $A/kdamonds/nr_kdamonds
  echo 1 > $A/kdamonds/0/contexts/nr_contexts
  echo paddr > $C/operations
  echo 1 > $C/addr_unit
  echo 5000 > $C/monitoring_attrs/intervals/sample_us
  echo 100000 > $C/monitoring_attrs/intervals/aggr_us
  echo 100 > $C/monitoring_attrs/nr_regions/min
  echo 100 > $C/monitoring_attrs/nr_regions/max
  echo 1 > $C/targets/nr_targets
  echo 1 > $C/targets/0/regions/nr_regions
  echo $((4 << 30)) > $C/targets/0/regions/0/start
  echo $((5 << 30)) > $C/targets/0/regions/0/end

  # probe 0: matching=Y, probe 1: matching=N, probe 2: no filter
  echo 3 > $C/monitoring_attrs/probes/nr_probes
  for i in 0 1; do
      F=$C/monitoring_attrs/probes/$i/filters
      echo 1 > $F/nr_filters
      echo report_made > $F/0/type
      echo user_report > $F/0/filter_report_type
      echo Y > $F/0/allow
  done
  echo Y > $C/monitoring_attrs/probes/0/filters/0/matching
  echo N > $C/monitoring_attrs/probes/1/filters/0/matching

  # one producer covering the whole watched range
  P=$A/reports/producers
  echo 1 > $P/nr_producers
  echo user_report > $P/0/report_type
  echo $((4 << 30)) > $P/0/addr_start
  echo $((5 << 30)) > $P/0/addr_end
  echo on > $P/0/producer_state
  echo on > $A/kdamonds/0/state

The writers are 1 to 16 copies of a small loop that writes "submit"
to $P/0/producer_state for 10 s, with a 1 ms sleep (the first row) or
none.  Hits are read from the damon_region_aggregated tracepoint's
probe_hits.
