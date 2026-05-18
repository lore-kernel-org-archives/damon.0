Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C463A3E73
	for <damon@lists.linux.dev>; Mon, 18 May 2026 05:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779081777; cv=pass; b=Lq6hBySg5kyMdwfc6e+iodtvAKLpL5kQrLMWfRhEGSkAbEFN/93fXWiyVpnjLy/w6WyeqTDqyG9yMfkKthGrNvQI+FfB1546QBR4NAac31HZm7XLOCTRILrpXLFLsn9Og15HgPP7uhjqyskXQ4VFaLms0WXT/mLqo2P1Zbd67Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779081777; c=relaxed/simple;
	bh=4VXYNdBtz6O86chKmpEl3yDwemKRGMRk/kOMzAwANWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwuXqUWBiDFJCdSofyIHkP8XXDBu8Zs/Q+zlu4ft7WufgIgPAFQhoqMGxA06h8CudYUBanBccWPgpiuy4GWFAfS2b99pYOjNS2DsPR2qYHgsYwUFRnwpY0DLcVNeMIIspZ6vTWn64G9V53TWrfreRuXs78qNyNpgbFE3Js1lYKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiaxRlsC; arc=pass smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiaxRlsC"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1331e851faaso773134c88.1
        for <damon@lists.linux.dev>; Sun, 17 May 2026 22:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779081765; cv=none;
        d=google.com; s=arc-20240605;
        b=QLlo4KEkEI+b6BAZYBR31Lu5KijOk8hnKyaqwJx6BYQpDlqv5Bg7Lqa5SAvxj/DgPE
         9vvz1AA0SAbCjE7N4GYvmiNg/Rdg1tnFmXpMbc3CewpWvzP+Oj5LWYznlLIXg+4MuBUj
         0wdWzL1rEWkANPVnkWiQ1HM/vxt9cVTjD8CW+v75Wl8hF/ixRjduGcO7gtE8XOXyBZCm
         xfKRSiuEkZ4jZ2W2ItZyJs5BM6IFuLY7qJEGhZaZePruHERLmUdolN2EpbfXHRrbHNkX
         jcPrWFqLph8BdeHjnFUS3oVMXR9NotdFf39rMvRZDhntJXl7+Q1swX/G8B0rFqE7wqLg
         cUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tVrmc1+PV/eXO19oXbXbSS9nJEY6DfKgzD6K9F2BhAc=;
        fh=g3VMvJQux/HSLIVicncr24svuVPzuNK+KAx5AQfJAks=;
        b=jRbeisFQTvcZOse6qU9HPq7QrWTIA6EYoaIBVvpDZo4fYysCVoDHXd7G79zphKCEWW
         w6VZSsH1hKCbuw8Ys4pXXmfrMbja1CrTWvE59EXhE2aJugKruxbO5pCebOhdNLNdEpco
         BUqyqyqNvnP088DtVRerKe0kselOpm2hdTLceYA1gQitujJqER+QFPDKMoVzXB3QQQMV
         W6aePbJ6KVOcZYeGuEw65YkALda+4uFRfH75yPG4jGsELbnKX3s1WiilK+sHnxpSxxxQ
         TUOuOfmiGG6UqvtiQSl53h/c3MqArVCT70A/8kKnPwo62yBOEeEhwHcZ+3k5vnNrSyOs
         QYGQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779081765; x=1779686565; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVrmc1+PV/eXO19oXbXbSS9nJEY6DfKgzD6K9F2BhAc=;
        b=WiaxRlsCuka759ZzewXgsmkpkNFNI1ks8L9VLg/dYBCRJkDLDsCjXzVxAbZRyQ8Iby
         sjHwnXvWbYSduzbqlIeYFvlop9CCdFRNwBRwql+q5syJhbJp/cs8aKcxRKoZv3isTMy3
         CQPik6cSEJt0pvtUCiz8a4sL5Qtcme7UpydFI6lN6ca0sQ13T+MitZG2r4Q8KTT/RVNy
         56+DhA5xSOFomTvYT/1qljo0RswmvyXmc6HCXpcUZtxi5QF08SJMaDquXPn+5WEPHPiV
         cLSkXXkhrhpyl/wWD8q9FFaFGg3NMp0crDkIMueEKsXy8g2AOYFN+4UE5W9xxLVxqfau
         HpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779081765; x=1779686565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tVrmc1+PV/eXO19oXbXbSS9nJEY6DfKgzD6K9F2BhAc=;
        b=rAifmg4NlomZu/kBax37IQMQujj3YLV5UmPlj0tNIYnx3YndaEx9MsR3tn8xfuK03z
         HQ7TeIDT7W+uffS8AHFxWL8KzGayHtY0W457RwzmgQ3beUNZ+5XVzljfZLm7cBqXc7AN
         rFb0d/h2aZdu0y4znL5Ty19wDdk0kVBwzunmOT5zlpyQ+kbqtoI9L4HLKpCT6XS+k6qZ
         fI347J+gDci6HxVuuJHSSMAUFjcoyVyFYrDgWW8PowcO7LVn5ar5OQry2a+b+NvddxNJ
         KzKNcNMbt9HfiALQr1hiItRzcDiFtJeZ0V5o9x7paH7uRFj9gqJisXDCz0vXkPEScMUw
         wAig==
X-Gm-Message-State: AOJu0Yxo00YodsO30+3qi/oDL7nXwQMnS6Yrt4CvUV83IyEb/qFf74Fz
	a0a8B/P+jQ8zYfjh0ffKrPsvpNkXfY5VJOss1rI4PP+GArxI7wVggUujihNbJZKx4L0jEuhd1eh
	/e5wXoI/pAF2ardLVDSwYXETwiFpTkA==
X-Gm-Gg: Acq92OH8puqhmQkAaWt/EHUbwSOAplfTC6wSIk09TTwwAfI+1zE9H9FJyi91Sw3WsTm
	D4vm3A3l97d+CLi5nKTCKdXAFDmX6ZNNuotVEHBU4fg7iZmp+Wp/diuPhrd4zj1b5YbQPau9Nue
	m1bT3tsNcidrfOACCMtNNXEc7nVV8VKPFkR6bkW9yKSuwhVWLGSFCi2ZUpSk9i7aHv3jp1Ofa9x
	ieHj3SpEdk6nZ/uj0Rd9mAGphMa2Oi0m5gl0nSPp1/UOPNZuxJXm2EjJQnIW5FeLMeDQCx4dQEx
	ScOfUkY=
X-Received: by 2002:a05:7022:301:b0:12a:6d05:3938 with SMTP id
 a92af1059eb24-134ffc6a83fmr5895472c88.7.1779081765523; Sun, 17 May 2026
 22:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260516210357.2247-3-ravis.opensrc@gmail.com> <20260517183658.4510-1-sj@kernel.org>
In-Reply-To: <20260517183658.4510-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Sun, 17 May 2026 22:22:34 -0700
X-Gm-Features: AVHnY4LE0W1Cr7WTCe0QcWx8Sq82GcO7UNuwTXn-H1Hzh7EXFfcqQ3AqG5J0WCk
Message-ID: <CALa+Y14PXA_anNdvJCzx4RfKoKj6hNmEG39KUvMALtOBznprkw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] mm/damon/core: cap effective quota size to total
 monitored memory
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 11:37=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> Hello Ravi,
>
> On Sat, 16 May 2026 14:03:54 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > The DAMOS quota goal tuner can compute an effective size (esz) larger
> > than the total monitored memory because it integrates over cumulative
> > deltas without bounding by the actual workload size.  Once esz exceeds
> > total monitored memory, the per-tick "remaining quota" arithmetic
> > stops being meaningful: any scheme can apply to the entire monitored
> > space and "remaining" stays positive indefinitely.
>
> Nice finding!
>
> >
> > Cap esz to the total size of all currently monitored regions as a
> > final bound after all other quota calculations.  Add
> > damon_ctx_total_monitored_sz() helper that sums region sizes across
> > all targets.
>
> You could also make an arbitrary cap by setting the static size quota.  T=
hat
> is, if there are not only quota goal but also the size quota and/or time =
quota,
> and the different types of quotas disagree about the real quota, DAMOS us=
es
> smallest quota.  You could read damos_set_effective_quota() code and kern=
el-doc
> comment of 'struct damos_quota' for more details.
>
> So you could apply the total monitoring region size cap by setting the si=
ze
> quota of the total monitoring region size.  Could that work for you?
>
> Adding the total monitoring region size cap makes sense to me, and I thin=
k that
> will make user experience better.  But, if the size quota based cap works=
, that
> could also be handled on user space in an easier and even a betetr way.  =
If so,
> I'd prefer the direction, to reduce kernel code complexity.  What do you =
think?

Hello SJ,

Agreed.  quota->sz combined with the smallest-quota-wins rule in
damos_set_effective_quota does express this cap from userspace
without kernel changes, and keeping the kernel side clean is the
right call.

If the UX argument carries weight later, I'm happy to respin v2
with sashiko fixes addressed.

Thanks,
Ravi

>
>
> Thanks,
> SJ
>
> [...]
