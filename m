Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF85349B1C;
	Sat, 25 Apr 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777131204; cv=none; b=O27CEB00jOzYrg/blyYU/eDyhMS7M+s5X/F1giaWPx/JOjcpvo+9ZUxwPAytrTdN1n2x+VFaH8jVOkddkLmm/clCJPM5keh3ykV+DjkOWXyLS0DxVFNHJZXi8Izz/McPqgBkX1X4b4mYYeXh00rRUk/kdMeNZZbnt/4KqKYhUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777131204; c=relaxed/simple;
	bh=oHa+e+p8+CYUwF+PdhlYQEG7S8r7c9LNTCYQ6IDWIbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcSvpoPQwMqfxgNpkZ6PkT2A/jUbfvwNZcVaedfN99tTVIXo5zKBzFK+lAJuifUeAJRGV5/KgNTiD1nfM39J64N4jDrW1oHdvKyhwM+gAmJSP+5GU78hL7V8MVXu3hRB6HhduiCcP8yKuq11aBGEXea+Tq58MqCj/5n0wEZuI50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhLpw7Rn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhLpw7Rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2F3C2BCB0;
	Sat, 25 Apr 2026 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777131204;
	bh=oHa+e+p8+CYUwF+PdhlYQEG7S8r7c9LNTCYQ6IDWIbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PhLpw7Rn2ERR4T1johp/j8QL3I6KFvl/1P9IOoFxpQoj+MLDN89McxqF8hrMqa4it
	 p9QRl6Hj1p+ml/ZNMSaJon2OlcAAz6CxPExCan9cweUetmEa2n4RCmAH4MEvbEHtCi
	 tfwGaLOs627kiIsY/9asNkWVSK/8AkoqnNA6tXqwxBGI3Ld8J3R5NUZy6Lgxkr/2Wv
	 /AM0ciiV+Yhq9Hp91xLVMkg7EGspvnpkK5mtxoTXWgEos6c8joxs7U67qTu3Krd1Wi
	 yObumE9hEmtxEseOP35cr+C5BR7vyBhY0s6b+Fl8G1nTwI9ujID2NiJfDyjDTjSz+o
	 jBp9DNtxNbA2Q==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/4] mm/damon: introduce perf event based access check
Date: Sat, 25 Apr 2026 08:33:15 -0700
Message-ID: <20260425153316.89358-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAC5umyjcFm-iw31kgYP0Z61z7N=vMzkZKsvGZpYmNwNw3R_gHw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 25 Apr 2026 21:33:07 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2026年4月25日(土) 8:31 SeongJae Park <sj@kernel.org>:
> >
> > On Fri, 24 Apr 2026 12:27:07 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> >
> > > Hello SeongJae,
> > >
> > > 2026年4月23日(木) 13:34 SeongJae Park <sj@kernel.org>:
[...]
> > > My current patch introduces a set of kernel ABIs (.../perf_events/<P>/*),
> > > and if I want to control another field in the perf_event_attr,
> > > I would have to add a new ABI. This would be a significant
> > > maintenance cost.
> > >
> > > Instead, I would like to provide a single bin file where the
> > > perf_event_attr I want to set is written as binary.
> >
> > I'd prefer having single file per parameter, as sysfs is designed for.  It
> > allows keeping the input format simple and therefore easy to maintain and
> > extend.  Of course, we should carefult at adding new parameters, though.
> 
> Another idea from Namhyung Kim [1] is to fix the events
> specified by the CPU architecture being executed.

I think I need to study mroe about perf events :)

> 
> Of course, we would want to control a limited number of
> parameters, such as sample_freq.
> 
> [1] https://lore.kernel.org/damon/aZwLDAxf9eP0lPdD@z2/
> 
> > >
> > > > >
> > > > > - `sample freq`: A higher frequency improves access accuracy, but also
> > > > >   increases overhead.
> > > > > - `sample phys addr`: specify 0 for vaddr and 1 for paddr.
> > > > > - The remaining type, config, config1, and config2 settings can be found
> > > > >   as follows:
> > > >
> > > > The values look bit human-unfriendly.  I wonder if we could use more
> > > > human-friendly values, e.g., 'cpu' for type,
> > > > 'mem_trans_retired.load_latency_gt_1024' for config, etc.  Not necessarily we
> > > > need to fix this right now.  Let's keep discussing.
> > >
> > > I'd like to do it that way. These processes can be handled better
> > > from user space than from within the kernel, so I'd like to achieve
> > > this from damo with the help of the perf tool and library.
> >
> > Does existing perf event ABI also take that approach?  If so, I think that is
> > fine.
> 
> On Intel CPUs, you can read the mem-loads and/or mem-stores
> files as follows to find the value that should be set to
> perf_event_attr:
> 
> $ cat /sys/bus/event_source/devices/cpu/events/mem-loads
> event=0xcd,umask=0x1,ldlat=3
> 
> You can find out which bit field of which member of
> perf_event_attr should be used to set these values from the
> corresponding files in the format directory.
> 
> $ cat /sys/bus/event_source/devices/cpu/format/{event,umask,ldlat}
> config:0-7
> config:8-15
> config1:0-15
> 
> This conversion from symbolic event name to values that should
> be set in perf_event_attr can be done, for example, as shown below,
> so I think it should be implemented using perf in some way.
> 
> import perf
> 
> if __name__ == '__main__':
>     evlist = perf.parse_events("mem-loads")
>     for evsel in evlist:
>         print(f"{evsel}: type={evsel.type} config={evsel.config}")

I definitely need to study mroe about perf event.  I will comment after I learn
some fundamentals.  But I believe this is not a blocker of this work.


Thanks,
SJ
