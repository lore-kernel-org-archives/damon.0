Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE364A0C
	for <damon@lists.linux.dev>; Tue, 26 May 2026 00:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779754387; cv=pass; b=LnvNTRfEwU8aIRXdjpteE+hAXpIHotW/0SpdpnQJQ6wglqQwyR5xdYplJu/aSvu25m/MeO1O2wbzDX6Km/2R0CxTiixU07cPZVYVwLaKkx/RBCe9/u56FmTlalFC5r/pWDjoj1EGSXiRYPLtCAIHNwsDHTeJp15Tk/0HLJk5/z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779754387; c=relaxed/simple;
	bh=vai0eOmQcfvbPITa1BZ1JS5fG/MSLBrhnFyma9FiDik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WD+E+GS5KcWtDSmgNJPDT/fp7MzBxBovChFMIfdmCDuQdXMLdBGjngio3QMggHFS8cPyn/g1NLAWNEXCzTz/W5vkrk+ON5xd8hGqvJgpnHQVswikKl5Ja9XZNNXhi5jtrQe5YLDYgnDEKf5IZ4tIrwWAHTRfHd1PttGkYndfZmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8/krtQ9; arc=pass smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8/krtQ9"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1363fe80fe8so4402614c88.0
        for <damon@lists.linux.dev>; Mon, 25 May 2026 17:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779754385; cv=none;
        d=google.com; s=arc-20240605;
        b=LxXcPSP7xA3pHHAUx3wjXdSNI8sLSe9m1Nf2F76rVUuqrTJjAqb0NDLEGV/fzgaByv
         gfssLJ9Vx0AAYZwyKm7G1/xoDb/47oN2L3WGiM6NRL/HRBx1WuBbaoLglTx7jmvVeIJp
         hb+ex4tw2YQZNF3FCpxCyxwOrcFdxtRjbv9sd+ZKrHsVQV8Z2hPqUQR3NGB7/wzdZ4aE
         Z8nkybBpyRYChccy+SeNpTsJs3dSDBZli7u5X+YOEQ7wiSwDLOrym0ui1BFVq3DNYwBi
         5aXWA7x9BUbL58NjSgUq6vimEfLzD4cKRX7QB+x/VF7YJJFYteF9K3wOd1rW3+0aicES
         Yn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NZM/D9Xje151euoN0vcdWXtLx/j+a913RohvEO3czxM=;
        fh=RFTo20o3NmBN9KLEgSYr6ngkM5ZZEMaufqQA6u+W2Q0=;
        b=DCAJ0hFSeZQVP9sW4iXN20ndw6GBHkGgTbtdFAInNXlcls/4gw1AOK3m+zi2kT0L8M
         eeIgBAUZHYwe5uRLQNySc304N+kqs9ijWTMHeASJ+5bjGLQOkg9qR9geMmI6hf9OASun
         0/iLV3eh3N85g2j94udIj4jM7VOSusZGbtNVHh9T9wuQL2rS6I/dGvFAGFFjIYB+N2Zd
         NkUY2p7L9rp0c0aYdsPVo8mFEOGazH0QNf5l3vRV6RomFOeSfZ9R5Kpnya7qZxWJltqU
         1QkjRJYXrvh37pm2KDpli1JRKNmCwo3xWzrWwWrB0qGgwxlSXtOfau4Awi4qQdZRL8s3
         hYTw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779754385; x=1780359185; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZM/D9Xje151euoN0vcdWXtLx/j+a913RohvEO3czxM=;
        b=P8/krtQ9idra9fBn1FFG4JxY0rlckDUAmAPKCbBS63euO6JB7XppXPU2VM+2gsm9Od
         gvIO0Ji+3fXIkgQwFSGQsoyYOyYIZfH2szKE4S5dElZjamKkLVzHd8npCD6X+oZdAKNS
         A8Yna9LWjBIpBnWhzCOBSAZIufbEq/J5THLMV6nfPUfN3sknnnJni0Bx8gjOuSgEy++e
         LeaIAmpNKlX65iJA55+RySP9RcrAuOTwKONi6K+uCKDv95lqYrUcjptgZQsNjJZsALUV
         VA2l8Jk5ZCDFq+lEf0py/GVSiMgsZc3yrehK6ik87t6MurRpTE1gUIgDKRdB0YiKlSO+
         5kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779754385; x=1780359185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZM/D9Xje151euoN0vcdWXtLx/j+a913RohvEO3czxM=;
        b=FXXhQcQ60XL/TqrIfKogxqCehghXBR6Ydf+hho3iHYrfbIAFofh61gegcu0O7d5MZV
         WeS+kQ/d8UJ3Ll6q84qUpWDZtexqdotXLLcZoXB5rBHypRE2UwMRNLmNYn9OrRQ5Jr2w
         hRko+req+TA0c3X0fLvPaCCe51CqVIwFMx2cT5RYANv9cWPIXtv59LRK9mieusGq5Gf9
         YnI9EpVT9F3y9FmN0PT9+yGw3bmo63S/uFuwq6pki72VghhdcXCxnBkgcEiSQr3VD1o/
         xnN1fN7b0IXm7qpu9fhHHiYI/kYi+tazxlk58H6e/PKHijknR7yrPI5asvO3Q6Bg7XAp
         mCKw==
X-Gm-Message-State: AOJu0YzVnbdpMbgV1g9JhqxtKiqWWGZQM4jeKna4ied2y9wNQeYyDt/c
	xweKdiJcAAkbWWYZfpwyVPxqJAf2UUnTdmwP4GHlMH1zemJ1bYE0evyjd3uoN3FIZoWYC7MBDlv
	/iF0858oPRgv/1jxJ8fmo4gPz7BMdt9o2ZQx6KJ8t
X-Gm-Gg: Acq92OGtZiErKkHGBlRFaPRg/l7BPJhb4oJkKMi3VGlMNg4lxqKBiTc71iUPPc9vog1
	Zq5mqAvk/cjcmHBF/cxhAvWl4PbArd2geOaJSMfomhgKXkKdpXJ6UA7/v4oe3gsdd8OhgqkHD81
	Lk8tXtqjD8XSYz8yTkRr8S1NC+Fyh6LZlIu7TRaWJg9MvVEhr3X8G1ki7QNlO21mELY25UVNzLx
	vNMWKRqGmnBn/K8LWT3N5PPs+5GodMJvLmzeAfCatZyvRzbd3iUvIBRAlDK8+oWaFn8AfrBHZmU
	gEnis3Srz7tfGQ2BudyzD2lBGXVt
X-Received: by 2002:a05:701b:42cf:10b0:136:6b4c:a8ea with SMTP id
 a92af1059eb24-1366b4cabdcmr4072156c88.40.1779754384785; Mon, 25 May 2026
 17:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260525225208.1179-1-sj@kernel.org>
In-Reply-To: <20260525225208.1179-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Mon, 25 May 2026 17:12:52 -0700
X-Gm-Features: AVHnY4LCM9aFYoEoBYQcvTw5VA74tgxhVYsI9elev2Oc6luksy1gYYqJYXsjZ60
Message-ID: <CALa+Y14rhy8scVFhZqu2xCRdy1nHMjsytacfztKsR94jWvjbLA@mail.gmail.com>
Subject: Re: Roadmap for extending DAMON beyond pte-accessed bit
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, Akinobu Mita <akinobu.mita@gmail.com>, 
	Andrew Paniakin <apanyaki@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 3:52=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hello,
>
>
> TLDR: Let's extend DAMON for data attributes monitoring, andd then furthe=
r
> extend that for multiple access check primitives including page faults, p=
erf
> memory-access events and optimized AMD IBS-like h/w feature drivers.
>
> Ongoing Projects
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> At the moment, DAMON is utilizing page table accessed bits as its major a=
ccess
> check primitive.  Because of the limitations in the primitive, interests =
in
> extending DAMON to use different access check primitives, including page =
fault
> events and h/w features such as AMD IBS, were expressed multiple times.
>
> I started working [1] on the page fault events based extension for
> per-CPUs/threads/reads/writes monitoring.  Akinobu is working [2] on perf
> events based extension for lower overhead fixed granularity monitoring.  =
Ravi
> is working [3] on AMD IBS based extension for memory tiering.
>
> Xin Hao proposed [4] extending DAMON for NUMA systems in 2022.  Pedro Dem=
archi
> Gomes proposed [5,6] extending DAMON for write-only monitoring in 2022 an=
d
> 2025.  My page faults based monitoring extension is partly for their proj=
ects.
>
> Types of Required Works
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Each work commonly requires three types of changes.  Startign from the lo=
west
> layer, the required changes are as below.
>
> Firstly, we need to extend existing DAMON operation set (paddr and vaddr)=
 or
> implement a new one for controlling the new access check primitives.  Thi=
s
> part, at least for page fault events and perf events are not overlapping =
and we
> could work in parallel.
>
> Secondly, we need DAMON core layer change for the reporting-based access =
check.
> Page table accessed bits are set by h/w and DAMON does nothing about it. =
 DAMON
> wait until h/w sets the bits, and later harvest the information by readin=
g the
> bits.  In other words, DAMON only "pulls" the information.  For page faul=
ts and
> perf events like primitives, we need to hook the access events and "push"=
 the
> information to DAMON.  For the page fault events based extension [1], I
> implemented damon_report_access() and related infrastructure for this pur=
pose.
> The implementation is quite unoptimized.  But I believe the design is goo=
d
> enough for long term maintainability.  I want us to use this framework.  =
We can
> make it works first, and later optimize.
>
> Finally, we need DAMON user interface.  For the page fault events based
> extension [1], I introduced access sampling control interface.  The idea =
is
> letting users control the access sampling in a more detailed way.   At th=
at
> time, I was thinking it is long term maintainable and Akinobu and I could=
 reuse
> it.  I still think it would work.  But, I recently got another idea.
>
> The new idea is extending DAMON for general data attributes monitoring.  =
The
> first change [7] for making it able to monitor not only data access but a=
lso
> general dasta attributes including anonymity of the pages and belonging m=
emory
> cgroup is recently merged into mm.git.  As the cover letter of the patch =
series
> is also explaining, the work has started for light-weight per-cgroup acce=
ss
> monitoring.  But, in long term, we want to make data access information a=
s just
> one of the supported data attributes.  Then, we can further extend access
> confirmation coming from different primitives as different data attribute=
s.
> For example, in addition to "PTE Accessed-bit" attribute, we can add "per=
f
> event mem-access reported" attribute and "AMD IBS access reported" attrib=
ute.
> I think this is long term maintainable and therefore want us to use this
> interface.
>
> Roadmap
> =3D=3D=3D=3D=3D=3D=3D
>
> Assuming you agree to use the data attributes monitoring interface, I sug=
gest
> us to do the work in below roadmap.
>
> Milestone 1: PTE Accessed bit as one of the data attributes
> -----------------------------------------------------------
>
> I will work on stabilizing and further extending the data attributes inte=
rface
> and internal framework to be able to support PTE Accessed bit.  This may =
take
> no small amount of efforts, but hopefully doable by the end of this year.
>
> Milestone 2: First damon_report_access()-based data attribute monitoring
> ------------------------------------------------------------------------
>
> Once the first milestone is completed, we will add the damon_report_acces=
s()
> and related infrastructure changes into the DAMON core.  On top of it, we=
 will
> further implement the first data attribute that utilizing the reporting
> infrastructure.  I personally think the perf event based one is a good ta=
rget
> at the momentt.  I think so mainly because the perf maintainers didn't sh=
ow
> special concern yet.  We can discuss the target again after the first mil=
estone
> is completed, though.  Hopefully this is doable by the LSFMMBPF 2027.
>
> The timeline is just a gut feeling.  It could be done much earlier or lat=
er.
>
> Milestone 3: Parallel extenstion for other primitives
> -----------------------------------------------------
>
> After milestone 2 is done, we have the user interface and the infrastruct=
ure.
> We will be able to further implement our favorite access check primitives=
 on
> top of it in individual schedule, without blocked by each other.
>
> Collaboration
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Milestone 1 and damon_report_access() part of milestone 2 would need to
> primarly done by myself.  If you are interested in this project, reviewin=
g the
> patches that I will post for the milestones and doing some testing would =
be
> very helpful.
>
> For the second half of milestone 2, I may need more help from Akinobu, Ra=
vi or
> someone else who may experienced with the first target primitive.  Maybe =
I
> could develop the damon_report_access() part and post it on the mailing l=
ist,
> and the other collaborator could further develop the first target primiti=
ve
> extension on top of the patches, like we did for vaddr page interleaving.
> Let's discuss the details after milestone 1, though.
>
> Request For Comments
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I would appreciate any inputs about this roadmap and plan.  I'm primarily
> curious if the plan and the timeline makes sense to Akinobu and Ravi, who=
 are
> actively working on, and might need to wait for my milestone 1.  Also if =
there
> are people who interested in this, please feel free to add your inputs pu=
blicly
> or privately, in your preferred way.

Hi SJ,

Aligned with the roadmap and timeline.  Will rebase the AMD IBS
series on top of damon_report_access() once milestone 2 lands, to
help test and review the interface.

 Thanks for laying this out.

  Best Regards,
  Ravi

>
> [1] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org
> [2] https://lore.kernel.org/20260423004211.7037-1-akinobu.mita@gmail.com/
> [3] https://lore.kernel.org/20260516223439.4033-1-ravis.opensrc@gmail.com
> [4] https://lore.kernel.org/linux-mm/cover.1645024354.git.xhao@linux.alib=
aba.com/
> [5] https://lore.kernel.org/lkml/20220203131237.298090-1-pedrodemargomes@=
gmail.com/
> [6] https://lore.kernel.org/damon/20250129044041.25884-1-pedrodemargomes@=
gmail.com/
> [7] https://lore.kernel.org/20260518234119.97569-1-sj@kernel.org
>
>
> Thanks,
> SJ
