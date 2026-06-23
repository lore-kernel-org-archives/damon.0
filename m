Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA89327C09
	for <damon@lists.linux.dev>; Tue, 23 Jun 2026 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221395; cv=pass; b=jDEdX6mwuDzu4IuQNcLnM3OsVRkP3Rp/H8y5Q03xK4W2is1TcBMfZwGt7JMt0xGmfsRIrxFqLoeD4kY2eqegIlQ+Zj5pzl1WyI7JD7iBAha8wNGMgvriCwbRGDihVF4kPJcOO3qwsl7j+oMv8wgFJRbLNgrcnebEMaZynq4iGKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221395; c=relaxed/simple;
	bh=pvopdsMv5vMxVcxFnrVZ7Q3OIZo7brgzX0LyyVbmd/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJifC9m7qm8XlALc5Oq4bwH/QbcfODeyVsPyHWKM9THAvS4VqZPCmt3ghR3ZmgdqCFMbmXgRiHy1MHFW1ctx67JmZIwWsK6mD0CVxSeLx5ItRw0yYuUWgWYHHRdxlQAlxnQ4kkLeyU0k39qdHCTxTDuROU4EqpaNfdgg/CaNPgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdQISPJr; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdQISPJr"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dc6fbf3e86so61985407b3.3
        for <damon@lists.linux.dev>; Tue, 23 Jun 2026 06:29:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782221394; cv=none;
        d=google.com; s=arc-20240605;
        b=F+bLWS/0+QF57ufwItWDXplAwsY0tA63Kg3gu/obdHCaP+0gJgBfNjduYQoxeFsomo
         LQLqnTE61FaY9/qvxnt/4FucoJF6NfqfQ+c6VRzWboR90jLzYBtWKSUC7f7UcsR8Au7L
         btanoBSIFWuZ3o5J6/m96QVC3AjhG4wAocSktfnG4wepPRpCjDenmsF7v1q79i/HDJL5
         Ft9Hd0S/QhRYisdfhUPIqJKFX9dltCCTZ+EMleWLbtz5D5KQp7RXfvHG0bWMxYIkQvkf
         8YOsrVrfStKaWbbFHnTUsTe+v7rHynoUN47KsmRFP6FEqG5KXtWM0LKMOls+SgTSK7Q8
         Qa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FmHmIXXw9DS5fEEeykM6L+uF9W8BEvYOXYiQBx9JZS4=;
        fh=9/H8MzIoRJ+4tm3tDGzNkpk8SKR80b2sLi41+uvnoiA=;
        b=MUWN/eYzrmdjgR3apLEeLA9+G/6iOkdtRyNbUGkIfq2Vdnd33mgCK34vchaTFQB/FF
         X3Xi+mmIcBfZgMcxkfcmwl5n925ekuchDazJ1rt6CfcqJ4t/d/dZIa6u+h3ENMOlerTz
         BjVvsIKKMS8Gd9gtaL3BkWQa1LkqPjwp2aHDe6a+PhoLDsqNxFv/RCTNEqZvW4LwTxJU
         Yckxi8+Rai7Sz2z8VLrRz4wwQJsIwgkZ2tle5D+5UQFRrbZuDzc67Y02aE8Q1/+0SbwB
         iwq9E3qyKplTlSvW6zieUmNjeY00VA8hGkPJf9Mdf+6hwY47S6ljdPpFP5+7hhPiXHJd
         XYFg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782221394; x=1782826194; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmHmIXXw9DS5fEEeykM6L+uF9W8BEvYOXYiQBx9JZS4=;
        b=ZdQISPJricTuXEjNZiJjitRaHDKfEdPRgSNMCkXNGx1VZR8zV0OKiDbbBzvZfGUbRq
         bb7BkIpcHJ7O13IEiDxG8rUriweLiDVteSbQpSixgRvGOnELq23jRYs/+xJJVXEVHlIo
         Tzs8X1eCsQfvlw8vPuVEoyJdMYVYGU3cboUYeCSXsOquZW6DnOqM51B6zcn+6lF4nbRi
         En4R1FV+6f4zwXbcglOS2Dyd6ZffbDH4koKwekauSEH6r82mvYFZJSinCGpFRJzbczLN
         5yK9PQIZIJMb5V+sxNrcKYszDIGhq8ebs3CViwVHfcaU4lDTkVCg3gP0nmR0gu7HSj5I
         PXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782221394; x=1782826194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FmHmIXXw9DS5fEEeykM6L+uF9W8BEvYOXYiQBx9JZS4=;
        b=mq8OTlS8Xp89JuGyXr2NeBMwPK3jVdAgyO8MzrseXgbghmUWyW8l5t0gU62mR3EaHJ
         8a/DhoiFZA8CQaNDT+OGaEvHqLqw2XcEdSzpIt/sxRxcGwyVMfSci+f4AIfH4pL706vs
         sxJdJq/Ekfrk46kj7ks5LY2U/ZELnP5ba0NPIlAWtodtCvv6XfgxplHpMzfdWgk7bK0u
         2jUaIFpEg/amxU3p8Q/QjE+UEotS4bK1zH8OMcJmlSvEywmHruolUhE/FFhZ7CycpYzM
         PGJV+65GSv9c2rVVWAXvRkE6wTM0V1Q/SbJ0FPKBCJVwy8uFkD5FFTKcTxIIFZegrLnS
         RhAA==
X-Gm-Message-State: AOJu0YwSoITdBfuQ0KFMCKQO1fwTksh+t1NSCDv6/kvOnAcwdQWX8B92
	WBsdz7DlCRD0B7AM8MWE7M6j9HpFN1CiTaLIM38eGkWoqO9+9rxWRAT10eDmAdxHEG5H+dYm1IG
	ZzZA+/eWyOdYPPA6u7U1buEP8qVmybkk=
X-Gm-Gg: AfdE7cn97EKDtqOw+/HcdFPQRrgRhZ8BrIE42oAa3rEaR4me1aHx9uHzlRNfOPKKYP+
	TAv87yGdZntT9Xvp+fFTFOCvy6Qdt4oy0LxTSmPde/KnHt1Zz+XlhflglPUQISxxdXI3EU8JspF
	atBIpOHEdzfqblrdjuLVu5RU7za/Mq+2cbhEOzhOr5TnFjnbhUr18Y0b18POh1hZ2EMzPEaujFk
	83SE2qt/SFDoIZ8qOCk1/qmiJIcwrH27kuryjZDhw0AJT3sCtuRll5AalFtBA/b9XeubtUEJVEo
	fiiDsVcUOABC+6FjqztIRENwMdwUtX5t+GU=
X-Received: by 2002:a05:690c:9b0a:b0:7fd:2b49:181a with SMTP id
 00721157ae682-806c226341dmr27480367b3.19.1782221393456; Tue, 23 Jun 2026
 06:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622134933.35773-1-akinobu.mita@gmail.com> <20260622152432.32788-1-sj@kernel.org>
In-Reply-To: <20260622152432.32788-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 23 Jun 2026 22:29:42 +0900
X-Gm-Features: AVVi8CfnlzfNTmMwHdN7shEapsXJbXkpYk4ewUy7jToRUMM10YJXpvwK5mFO01E
Message-ID: <CAC5umyi0v8Z3Frtr4yL_LRZu9O7wWF1HZfVbutagORde_i-7XQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] damo: support perf event configuration
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	ravis.opensrc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B46=E6=9C=8823=E6=97=A5(=E7=81=AB) 0:24 SeongJae Park <sj@kernel=
.org>:
>
> Hello Akinobu,
>
> On Mon, 22 Jun 2026 22:49:31 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > This patch set aims to make it easier to specify the perf event setting=
s
> > proposed for DAMON by Ravi's hardware-sampled access reports patch set =
[1]
> > from the damo tool.
>
> Seems this patch is built on top of the per-CPU/thread/read/write monitor=
ing
> patch series [1].  We made a plan [2] to use another user interface, thou=
gh.
> The plan is, making the interface ready for page table accessed bits base=
d
> monitoring by LPC'26 (milestone 1), and implementing the perf event based
> monitoring on top of it, by LSFMMBPF'27 (milestone 2).
>
> So the eventual damo part change for supporting perf event based monitori=
ng
> will be quite different from this series.  I guess you are sharing this s=
eries
> not because you aiming to merge it as is right now, but just for sharing =
the
> code with other stakeholders like Ravis, not me?  If I'm not wrong, I wil=
l skip
> this series for now, to focus on the milestone 1.

Since I will align with the final user interface later, please focus on
the optimal interface for Milestone 1 without worrying about that.

> Please let me know if you want more of my feedback.

However, even if the interface ends up being completely different from the
current one, I believe that enabling configuration via `damo` using
symbolic event names like this would still require calling the perf
python interface (`import perf`) from damo and modifying the `perf` tool
itself; could you please check if that approach is acceptable?

Thank you for your continued excellent work on improving DAMON.

> [1] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org
> [2] https://lore.kernel.org/20260525225208.1179-1-sj@kernel.org/
>
>
> Thanks,
> SJ
>
> [...]
