Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068137BE88;
	Wed, 29 Apr 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473286; cv=none; b=N3jeayfypi4f1Abq0LUsE9mOLCgxNarK2vSF7ti0HF85A+hExhDikmrCxRmQ9dVfKHd845q7Zd1mgk+H6/poh8OPiJLAPKED2G7bhTlVH1G0mswE3tLMu4XbE7uK6MMWYDwgEYgrmkyKOVQK7QRHBDVQcqnR5Pyahldu5IFZO1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473286; c=relaxed/simple;
	bh=e5hLY/1duIfoRLnw4lk6GdF/lAYCUBK8rW2RGY9+4L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZnJOiglrM7m9AmeCxgmFOl4tijfzuU14eW0a/EdPk7wHJ4bGpimCVT4Gh64QSi671X3OHzhhgCnzzQ99LCLfal8Xh1vXml4uN4RpAD0vWLFOH63b7wfJYTRfYdFzD16GI29hEcMCSKi6g35s/WbZChsFdzg+n+1+BxxMw8IxSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDTZF+R0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDTZF+R0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E2FC2BCC4;
	Wed, 29 Apr 2026 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473285;
	bh=e5hLY/1duIfoRLnw4lk6GdF/lAYCUBK8rW2RGY9+4L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDTZF+R0wd1WC9R5L+2S2Uds+N+k4E3jbb8Gb+4pWuTQ+DqwR4XtuTx2EoHjwGUh4
	 /PJJD7HnU4+joTG2W9Vm9OzHYVo+obg6wG0wsEOlMXEsx99UivQ2cJvb8PGFnw6Z4M
	 IcK5hioK6hZHin+n7MDZLYwXSKwiyx4wnIKjbNIu8aHt5hUnF//tzfCfDplgcJlNei
	 4vZYPf0kwBLxCDZMqSpJT+JwZBN83K9JDHlhJr2u1UqTqeK/gncPD4za+YNkioJgoP
	 4/FOnBUgVL+zZy/fKia3/SZHmhBKu6BP4wVOqLbWzSCS2zjFHEtJrG1hNBOiHVMILj
	 Ck7k2bTRYBvPA==
From: SeongJae Park <sj@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/4] mm/damon: introduce perf event based access check
Date: Wed, 29 Apr 2026 07:34:34 -0700
Message-ID: <20260429143437.94020-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <afG6sg3juuJrDEbO@z2>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 29 Apr 2026 01:00:50 -0700 Namhyung Kim <namhyung@kernel.org> wrote:

> Hello,
> 
> On Sat, Apr 25, 2026 at 09:33:07PM +0900, Akinobu Mita wrote:
> > 2026年4月25日(土) 8:31 SeongJae Park <sj@kernel.org>:
[...]
> > import perf
> > 
> > if __name__ == '__main__':
> >     evlist = perf.parse_events("mem-loads")
> >     for evsel in evlist:
> >         print(f"{evsel}: type={evsel.type} config={evsel.config}")
> 
> It'd be great if we could have something like this.  Currently we have
> libperf (in C) in tools/lib/perf but it doesn't have the parser yet.
> 
> Anyway there are vendor-contributed event/metric description in JSON
> under tools/perf/pmu-events/arch directory.  You may extract the event
> encoding from the JSON and convert it using the sysfs format info.
> 
> On Alderlake, the 'mem_trans_retired.load_latency_gt_1024' is defined
> like below:
> 
> tools/perf/pmu-events/arch/x86/alderlake/memory.json +128
> 
>     {
>         "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 1024 cycles.",
>         "Counter": "1,2,3,4,5,6,7",
>         "Data_LA": "1",
>         "EventCode": "0xcd",
>         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
>         "MSRIndex": "0x3F6",
>         "MSRValue": "0x400",
>         "PublicDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 1024 cycles.  Reported latency may be longer than just the memory latency.",
>         "SampleAfterValue": "53",
>         "UMask": "0x1",
>         "Unit": "cpu_core"
>     },
> 
> I think MSRValue is for attr.config1.

Oh great.  Thank you for kindly sharing this Namhyung!  This makes me feel perf
event based DAMON monitoring even more promising!


Thanks,
SJ

[...]
