Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717782C11E6
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782436444; cv=pass; b=JIXJb/HBLHuM9uTikyUlIkFRbzeAT9PyB2RhXcUJHg+f2RDRGXaUQteRKhXVFWZQfvxMlqmHIlyuu8aplly3Wv/9xrOAcz6XLPSpwIIEnP3FjKo9Mtx/R9ricMQSIXSwXSxOcUJfzHn/bqIdM1vf774TzBGqqW4zMx9cdc8LaeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782436444; c=relaxed/simple;
	bh=rtrg3DQaQYSKGWCB0QbtWivfJ+mli+yXS4Opc9OEzwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPmly12DAHJoJYmIr8hLOcvZoFcMs4H4KL9DYecyII8KIG5Cd131tERAPCkwer/mdnDjNqo6cp0cFTDGCprEb4QkIb6T24rdjQr1h/g3oSVfEZf5vDY9Gd+YXOiPJrnv7JhubFRRxpDiDKI5GdHzbaXOx1wny7wnKBfUWj7vm3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qpi55YlB; arc=pass smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpi55YlB"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-13986d61b4fso664028c88.0
        for <damon@lists.linux.dev>; Thu, 25 Jun 2026 18:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782436441; cv=none;
        d=google.com; s=arc-20260327;
        b=NWLBernngmynEh2P8R763SUbtQ2foq3Y+wK7hodb42AD6y26SJGkjb7hz8uVQVYfu+
         suhq2PemH6IgCcTWYK92YHO3XI407jqO3UCLnAVJRplGHefa42Q4K5NoPquawVXyaYTR
         kT1rklYXoB5bHr4Uiq7zbslaeQvY+kcOywsZztTXK400X5g3YQy5Z1EwmPubUR+9HUKu
         n5eWUb6SJJYuqppr5Q4KpcgbqEV+slLMH1YOHCcff0+7lS4J4gQ6KOR4IjPzVW44rIwp
         bwAtZpzYHW18DbJ3PMrxtvKytFhL+QbhMf8MwdUVYwUekb0NoEWuS6gNFHSTmDmF8JiW
         PMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0QrPux/jb9B/TQh4lL67jDfn0fMtva20UhkYnPdI7a0=;
        fh=s47PAcKipJ9bw9j9yCxJQPiV0kVDCtA0ao3w48gUVJU=;
        b=aerIHXMIqY9M3xiO5sJMltLo6IYumuiS3RwMyhKT/9d3sBf6gtj4n3+u0HC+ikCZ34
         5G7lNyzJ3j8DOiNZUw4sv7AyRlN/VwzAVtmCiOp5nVAA3qnsQS3pUz9wu6Ylk+khv9w5
         FgGg3VppAU3/6+5BmUuEB7Q+HDU6+YOWiQZl4OHt2y0NrbkEMALoc1x0XA6jtizG4Txh
         s6HKE5VlCfaXDbdl0AFX9DVzG6QOPNye67r4Xk0kZpttftkWZMMtsBSQlVqWENAQR1ye
         8a/p2gIrb/+vgu+kNaj90y5ABBXlA2/pO4rY2FugRuYJL1nBklRLAUj/jQ5AeZU2p8W2
         e5fQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782436441; x=1783041241; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QrPux/jb9B/TQh4lL67jDfn0fMtva20UhkYnPdI7a0=;
        b=qpi55YlBJSN1zFX/tG7zNTTqp5WKMubTbUTI04DlbRI5Cx2VTex1ydjAe1uQQ8jYXu
         tzRemNVVw6K9iasDYeDL/MvVTmGP4e1chS5ZH1qm+kbFvfNIFaYCPSYuO04gQ9ycosMw
         nfRkyxa/axF3+STKTu3c+j19xQ8vOMSeaFLMJCH3KmY0uEN2t7Hg/JPsAr1pdy6/Ffnh
         5MXW5PVQ0ROVGMpeFr4bsGUs3HUXdviISByQz1J8HVqcEPwpUguYsUtbV1oqz+HS7A0J
         tmbp0mQ006jO0CWKRQ2/v+HI0/DRvYDcEFFm9ch4ss3jo1y4uwuzXt5+h3dVzTuF+FwT
         HuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782436441; x=1783041241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0QrPux/jb9B/TQh4lL67jDfn0fMtva20UhkYnPdI7a0=;
        b=B5Qjg0lHeWL6185yjU1X8IUBcMUgRsVlHtM4Ti6qohneVOXm+KL7C65oKU1JDjXp2X
         P+PUM8f74uRBZgKuqVtL3SSOjTqpNooSMKir1TjIvb44kSJU+5bIaE1OVKloQKnyNF+8
         W/vgO89xBDnWqwBALsb9S+N/a3l8I0wU22owTywbMoIpENoAtkCdvd6XLw3wDYS34z/2
         YHRdkE1j70puRfRwYjaTFWHPaOm1jGT6oomHHTKYGtu+7EJZS7aNph4LsLfpS5VpjzSX
         n0oLLxJesbJzaT/UU0zDHiWw6PFi/ig6RD8qXN/Di2HWh2WM/c4ZN6GQQNugtDUEvYzs
         En1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9uVVhfblxzuwqctZuthFBmVqZ5MR8YExqTEcoQ8Va3WaNwwr0EM+gWGFSEV97X0m/Rs8AXHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLdneCzDGDQvxQyu5S7gFRaV29jg7sh3fiiiFnQYQgRg+WZ4AT
	ijb2fRcWczVkFrtf/78HJ4paSMib866gzHkI+vh5Ugf0LiIp9RzJuOYsiIaMbPrjYe/sXfbZlWk
	OB5wYB3HTg5V6yYpEFIg3yK9Dfjnhaw==
X-Gm-Gg: AfdE7cmES0aRkp6TgyHaiOvZaAj3FzYh3+wE9JRSDonsidngih9O/Sr99u0ebahO3sv
	Jmq/KQFXEjYWFl+CL762SoCSf9EfSZEBtQDfuxtJ8yED7He6c9NNWyEUSYooIvtA6/6E3WmCh28
	O+bxlvqmXGhqE4z4UeStR95tBYzgDKxwKbe+UQcrDz92VtigZ1FFPUVPMuMpNx11cXy60xcweBA
	243TBCN86peKLDAR9pvpn1pnMOqRuV5Njyne1osRDt0sCmZx3hrOsPc6R1N9B2jFYhvxw==
X-Received: by 2002:a05:7022:6726:b0:137:f4ec:29ff with SMTP id
 a92af1059eb24-139dbaa660amr3557337c88.22.1782436441314; Thu, 25 Jun 2026
 18:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260624001425.77489-1-sj@kernel.org> <a9018e68-866a-c251-9e0a-67e31f4baec2@huawei.com>
In-Reply-To: <a9018e68-866a-c251-9e0a-67e31f4baec2@huawei.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Thu, 25 Jun 2026 18:13:50 -0700
X-Gm-Features: AVVi8CfGl0EXx2soTnROovfPq8W8ILXy4EngHWeoIXW7I1TDJmmJsZwRtoDNA1Q
Message-ID: <CALa+Y15kQbXW8NnZtbjr79_K9ooBBy5JemgHXqASABsNPJRqgw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] mm/damon: hardware-sampled access reports
To: Zeng Heng <zengheng4@huawei.com>
Cc: SeongJae Park <sj@kernel.org>, akinobu.mita@gmail.com, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, bijan311@gmail.com, 
	ajayjoshi@micron.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Zeng and SJ,

  Glad the branch built cleanly for you.

  You can also refer to this branch, which carries the same series
with a few fixes from an internal sashiko run, folded in preparation
for v2.

  https://github.com/ravis-opensrc/linux/tree/damon/perf-event-integrated-r=
fc-v2

  Note this is still based on the v1 sysfs surface (raw type/config
knobs). The v2 I post to the list will reshape that userspace surface
to align with SJ's milestone plan, so the configuration interface will
change:

  https://lore.kernel.org/all/20260525225208.1179-1-sj@kernel.org/

  Happy to help if you hit anything while testing =E2=80=94 particularly
interested in which PMU you're sampling with (PEBS / IBS / something
on your platform).

  Best,
  Ravi

On Wed, Jun 24, 2026 at 4:23=E2=80=AFAM Zeng Heng <zengheng4@huawei.com> wr=
ote:
>
> Hi SeongJae,
>
> On 2026/6/24 8:14, SeongJae Park wrote:
> > Hello Zeng,
> >
> > On Tue, 23 Jun 2026 22:08:03 +0800 Zeng Heng <zengheng4@huawei.com> wro=
te:
> >
> >> Hi Ravi,
> >>
> >> On 2026/5/30 0:56, Ravi Jonnalagadda wrote:
> >>> This series introduces a vendor and PMU-agnostic substrate inside DAM=
ON
> >>> that consumes hardware-sampled access reports through the standard
> >>> perf-event interface.  Userspace selects the PMU through sysfs (raw
> >>> type/config knobs), driving either Intel PEBS L3-miss sampling or AMD
> >>> IBS Op sampling.
> >>>
> >>
> >> [...]
> >>
> >>>
> >>> Ravi Jonnalagadda (6):
> >>>     mm/damon: add struct damon_perf_event{,_attr} and per-ctx perf_ev=
ents
> >>>       list
> >>>     mm/damon/sysfs-sample: expose perf_events configuration via sysfs
> >>>     mm/damon/sysfs: install perf_events on apply
> >>>     mm/damon/core: per-CPU SPSC ring drain and damon_perf_event lifec=
ycle
> >>>     mm/damon/vaddr: implement perf-event access check
> >>>     mm/damon: add damos_node_eligible_mem_bp tracepoint
> >>>
> >>>    include/linux/damon.h        |  80 +++++
> >>>    include/trace/events/damon.h |  49 +++
> >>>    mm/damon/core.c              | 403 ++++++++++++++++++++----
> >>>    mm/damon/ops-common.h        |  39 +++
> >>>    mm/damon/sysfs-common.h      |   6 +
> >>>    mm/damon/sysfs-sample.c      | 579 +++++++++++++++++++++++++++++++=
++++
> >>>    mm/damon/sysfs.c             |   3 +
> >>>    mm/damon/vaddr.c             | 267 ++++++++++++++++
> >>>    8 files changed, 1370 insertions(+), 56 deletions(-)
> >>>
> >>>
> >>> base-commit: 4c8ad15abf15eb480d3ad85f902001e35465ef18
> >>
> >> I wasn't able to apply this patch series to the linux (and linux-next)
> >> mainline branch, and also had trouble identifying the source of the ba=
se
> >> commit.
> >>
> >> Would you mind sharing where this baseline is from?
> >
> > TLDR: I pushed [1] a tree having this series applied on top of the base=
line to
> > GitHub.  Please feel free to use it.
> >
> > I think the baseline was a commit on damon/next tree [2].  Because damo=
n/next
> > is continuously rebased, we cannot get the commit in a simple way.  For=
tunately
> > the commit is still available on my local tree.  So I applied this patc=
h series
> > on top of the commit and pushed [1] to a branch of DAMON kernel tree at=
 GitHub.
> >
> > Note that the branch is not guaranteed to exist there for long term.  B=
ut
> > hopefully this series will be merged into the mainline before that.
> >
> > [1] https://github.com/damonitor/linux/tree/ravi_hw_sampled_access_repo=
rts_rfc_v1
> > [2] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profi=
le.html#scm-trees
> >
> >
> > Thanks,
> > SJ
> >
>
> Thanks a lot for providing the branch on GitHub. I've pulled it and
> confirmed it builds cleanly on my end.
>
> Appreciate the help!
>
>
> Best Regards,
> Zeng Heng
