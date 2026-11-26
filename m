Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658664;
	b=XocKeR67rdk8Obv60Uq0leOO/xeewDPNLPghCo8BRyVLD90PZ/eu5Rim3BCwuEjSp6gx
	 r6TjsQ70FAS1sxu0x5v61e0Km2u4UvFxd3RyOqrnypZAL79G0xjDWQDFaNri0nsam7/OR
	 MQ/VXfelaJDsHDDvZUy/gaIktpy2QnpL0j4mKFz2qhoO+3QA8u6N66TiBB02whR0lzB8N
	 A5Y8UURxVbM/2Yh5M7MD8zOOyGeG06GhuiUxlbEHn7QTaiBWYg6dqEh0GY+MMerf2JHdA
	 42828Fr8BCixtScvHVnMZ0IL8wjwmAyScXQYfBSS6LSqcuRkimcXXWHt8CaL2qL0Iqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658664;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=liXpri4l+8f0qFYwYuywNL9hfYgq5mI2uGuMxDVOQ14=;
	b=Klghl7BTT+DK1JEiiOIY5n462BXfcqJS4+AtYvb6UC+3TvhE2wD1HCUEcwv1rq8+P829
	 LkolR4KjpCT3oTZhAMqFLOmrAvw4eDGd2uHZkb6PzMf5/dNiB87wcPL6/vKpzm+UUMRug
	 k4bSUchpLj8xlyNyPV0TsIVPHQLb4TECjPaXZ7vNp1mZr72CWVnl52Ox4KNXP4rVjB3hv
	 DgxQVfA1SjvYDUk5cokVFpSIU3VUClQ6u3Jcp+mXhlibE3yc7I4KkXYHfog0bo82cLwO8
	 1mOrFwkWzreQfTmcR1L9LOsTFpsO6y6i8lujaWQGCwCBBfbfR6ACvK9zyRbc384F4Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgkliDEz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4CB606A31E;
	Thu, 26 Nov 2026 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgkliDEz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A8E1F000C6;
	Thu, 26 Nov 2026 02:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658664;
	bh=liXpri4l+8f0qFYwYuywNL9hfYgq5mI2uGuMxDVOQ14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MgkliDEzz48SDtPEkoj1EzzSbv+0i+SwDuizIFFidXAbXKbaN9ogCauoDp4szR61n
	 pld4i/EA5lgSprrlPKu3sipbIAtN0nQkVhPi8saJ6u8AqX8sETALWfR3ff00XbzUHW
	 Q2UtEe7/QFvLqF6YzOGZCKQ7GonA7VIrhH2ekXFjambZEJ5akMBR99FQtHRn0b3OI3
	 Tbs1rQnNUF1ac0fSfPel71yx8RhtNY17o5XmklfN87u/1MVxSF7E4K/GckW3+FlfDJ
	 uMeF29fDjLSLXyA2qzBchiqFi/DFfQOSZWlACZXV/CVhBq9+ITmKpDDFHqiHDCl4+3
	 9opDI4xUrvhpw==
From: SJ Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 00/27] mm/damon: let users report their data attribute findings
Date: Wed, 25 Nov 2026 18:04:15 -0800
Message-ID: <20261126020416.87656-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y14BNfdWH3yBY+ky1+Sb0YvRzW=gRcKKyGWWaBQkysPUkA@mail.gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ravi,

On Wed, 25 Nov 2026 14:10:15 -0800 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> Hi SJ,
> 
> I tested v2 as it is in mm-new, and wanted to share what I saw.

Thank you for sharing!

[...]
> 2. As the submit rate goes up, two things go wrong:
>    - with matching=Y, the probe misses the report more and more
>      often, although it is always there;
>    - with matching=N, the probe matches more and more often, although
>      it should never match.
> 3. Empty and inverted reports are accepted.  They never match, but
>    they take queue slots, and enough of them push the valid report
>    out.
> 4. On a vaddr context the filter is accepted but has no effect.
> 
> Where it comes from
> 
> Case 2: a busy report queue (13/27, 14/27)
> 
> When a lookup finds the report queue locked, for example by a submit,
> it answers "not found" rather than "don't know".  For matching=Y that
> is a miss; for matching=N it is a match.  The more writers, the busier
> the queue, and the more samples go wrong.

This is the expected result.  The implementation is more strict for type
matching.  If it is unclear, it says the type is not matched.

For example, if filter type is PGIDLE_SET and we cannot confirm it, it is
treated as not PGIDLE_SET.  For example, DAMON could fail at confirming that if
it was unable to get the folio for the probing memory due to some races.

> 
> The right answer here is 100 % of samples for matching=Y and 0 % for
> matching=N.  What I measured (the last column is the share of submits
> refused as busy):
> 
>   writers               matching=Y   matching=N   refused submits
>   1, one submit per ms     99.5 %        0.5 %          0.1 %
>   1, back to back          45.5 %       55.3 %          0.2 %
>   4, back to back          49.0 %       51.3 %         60.2 %
>   16, back to back         15.6 %       84.9 %         79.9 %
> 
> The numbers vary somewhat between boots; the trend does not.
> 
> Could a lookup that finds the queue busy skip that sample instead of
> counting it as a miss?

I agree that could reduce the error rate.  But I concern if it could make the
behavior inconsistent.

In my humble opinion, , the user could work around this issue by not submitting
the report too frequently.

But the more important question is, if the user really need to do this kind of
frequent report submissions.  I have no clue at the moment.  If it turns out
so, we could improve kernel side.

One straightforward way would be introducing a complenting type.  For example,
we introduced PGIDLE_UNSET to complement PGILDE_SET.  We could add something
similar for REPORT_MADE, say, REPORT_UNMADE.

Yet more possible kernel side improvement would be making the report queue
synchronization be more robust to contentions.

> 
> Cases 3 and 4: input checks
> 
> Two smaller things, both about inputs that are accepted but cannot
> work:
> 
> - Submit accepts a report whose start equals its end, or is above it
>   (22/27, 23/27).  It never matches but takes a queue slot: with 1000
>   of them after a valid report, the valid one is found in only 4 % of
>   samples.  Return -EINVAL for these?
> - A vaddr context accepts a REPORT_MADE filter (16/27), but the vaddr
>   operations never evaluate it.  Refuse it for non-paddr contexts for
>   now?

I agree this could be confusing.  In a sense, that said, those are working as
documented.  There is no documentation saying addr_start should be less than
addr_end.  DAMOS filter design documentation mentions "support of the filter
types depends on the DAMON operations set".  And the probe filter design
documentation says "The filters work the same as DAMOS filters".

I personally tend to prefer keeping code simple over making good user
experience, as long as it is not causing critical issues like crashes and/or
leaks.

If it turns out to really confuse users to be real problematic, we could add
documents or make code changes.

> 
> A minor nit in the cover letter: the loop
> "echo submit > producer_state" runs in producers/, so it fails with
> "Permission denied".  It should be "echo submit > 0/producer_state".

Good finding, thank you.  Maybe we could ask Andrew to fix this up, but this
might be too minor thing that readers could easily find out themselves...?

Thank you again for your review and testing, Ravi!


Thanks,
SJ

[...]
