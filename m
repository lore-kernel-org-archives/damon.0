Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096430E852;
	Thu, 26 Feb 2026 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069099; cv=none; b=K5by9ftacGyKwGbiWXGjTE/E6+RSi+zLfkybxg0EhbnHP3d5Z1C2xA+B9sFrVH+/DFtht9TMak6h6y9QCukW/2ayed9xk4PhZtL/KSInTCLaWb89hsZAXt8y/ec18xmYLmNfczwoxVCHaUo2gjmk5oCCZ5RSB/aUxgtYUTWiaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069099; c=relaxed/simple;
	bh=I/ziFTbAMjCXneuhtUTgdJvlfrUR6VbT53M4P1ydAH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5g932fRYJJtm1hJX164hA1uyQJTQ+cUF2mhrV3m2VFUuJKbzUMDMSJfTi44yAHbnz49E2jPfqKY0WeGi/hYT22+idnvgbjRYR8pfP6d9bmSKK6Gz2GPMwYkwj+s364U6x4219VKKorD+WwfKfClUg3hlZ1+AhMvm4SCOBxp0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfiMrcJA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfiMrcJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687CBC116D0;
	Thu, 26 Feb 2026 01:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772069098;
	bh=I/ziFTbAMjCXneuhtUTgdJvlfrUR6VbT53M4P1ydAH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfiMrcJAkE0GMMVdMf8NsWhZoIOBJoPn/8XvipCoHWSKE1sS7Kem3yZ0ta/GTafb4
	 bsVTtATQnWJBc0bJu4kkdI1lluax+qIGT1BZT0Ppu2TADFOb/7jBYGOubu1oi894yv
	 SEeCsxuwhbEJ7xSppFyYgBihYro2ZatmpJly2YdU2D3Rwu91TKM9ux0/uBSEA+NEG8
	 8J+gjiYargeHqxAlJRNlA4lT3k2OzLmEBpOtFlcK5T22dTwKMLiikiPgwl1xa6emaC
	 Iyl9vM0KCGC+wZcwsxv4Vi5GrjKPGQseXad3D4x+oY2s5WLKSqcuKNDZosvrUsoZPD
	 7jD8C4iidImog==
Date: Wed, 25 Feb 2026 17:24:56 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
Message-ID: <aZ-g6AfzY5xhtR6U@google.com>
References: <20260124023917.78649-1-sj@kernel.org>
 <20260124024804.78869-1-sj@kernel.org>
 <aZwLDAxf9eP0lPdD@z2>
 <CAC5umygJNCxbDwbTPc3FFRAO+sfHyxx=QSXXF9g2TSiQ4Bvw=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umygJNCxbDwbTPc3FFRAO+sfHyxx=QSXXF9g2TSiQ4Bvw=Q@mail.gmail.com>

On Wed, Feb 25, 2026 at 03:48:29PM +0900, Akinobu Mita wrote:
> 2026年2月23日(月) 17:08 Namhyung Kim <namhyung@kernel.org>:
> >
> > Hello,
> >
> > On Fri, Jan 23, 2026 at 06:48:03PM -0800, SeongJae Park wrote:
> > > Cc-ing linux-perf-users@ for any comment from perf people, about the use of
> > > perf event from DAMON.
> >
> > Sorry for the long delay.
> >
> > >
> > > On Fri, 23 Jan 2026 18:39:20 SeongJae Park <sj@kernel.org> wrote:
> > >
> > > > On Fri, 23 Jan 2026 11:10:10 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > > >
> > > > > DAMON currently only provides PTE accessed-bit based access check, this
> > > > > patch series adds a new perf event based access check.
> > > >
> > > > Very interesting patch series.  Thank you for sharing this Akinobu!
> > > >
> > > > I only took a glance on the patches, but my understanding is that this series
> > > > modifies DAMON to be able to enable perf events of PERF_SAMPLE_ADDR type, and
> > > > utilize the sampled perf events in the perf events buffer as the source of
> > > > DAMON's access checks.  In more detail, I understand enabling PERF_SAMPLE_ADDR
> > > > type perf events makes the perf events buffer filled with memory access event
> > > > information with the access destination address.  The event will be sampled
> > > > based on time (e.g., one access event per X milliseconds).  And probably that
> > > > sample data could include more information includign the CPU and the process
> > > > that executing the sampled access?  Please correct me if I'm wrong and add more
> > > > details I'm missing, as my understanding of perf event is very poor.
> >
> > I'm afraid you need to deal with PMU hardware details.  For example
> > PERF_SAMPLE_ADDR may not be available depends on events or sometimes it
> > may not have valid values in some samples like on AMD IBS.  Also hybrid
> > CPUs may not have same events on both CPUs.
> >
> > Maybe it's better to fix which event you want to use on each CPU
> > architecture.
> 
> Thank you for your advice.
> 
> Is it possible to get a list of PMUs that have the ability to get addresses
> (PERF_SAMPLE_ADDR or PERF_SAMPLE_PHYS_ADDR) from the kernel at runtime?

You can lookup 'mem-loads' events on Intel CPUs.  It should be 'cpu',
'cpu_core' and/or 'cpu_atom'.  On AMD, you can use 'ibs_op'.

  $ grep -l . /sys/bus/event_source/devices/*/events/mem-loads
  /sys/bus/event_source/devices/cpu/events/mem-loads

> 
> Or is it possible to detect that a perf_event initialized with a certain
> perf_event_attr does not have the ability to obtain the address?

I don't think so.  IIRC it will just have address of 0 if not supported.

> 
> > > > And one quick question.  Can this work on virtual machines?  I'm asking this
> > > > question the for following reason.  I'm actuaally working on a similar project
> > > > that extends DAMON for page fault based access events sampling [1].  The
> > > > project aims to use page fault event rather than other h/w features such as AMD
> > > > IBS or Intel PEBS, because my understanding is that such h/w features are not
> > > > available on virtual machines.
> >
> > KVM supports PMU virtualization.  But the existing vPMU support has a
> > lot of overhead.  Recently mediated vPMU patchset was added so you can
> > try that instead.  You'll need to pass appropriate options to qemu.
> >
> > https://lore.kernel.org/lkml/20251206001720.468579-1-seanjc@google.com/
> 
> Thank you for the important information.

No problem!  You may go with the existing vPMU if you just plan to use a
couple of events only.

Thanks,
Namhyung

