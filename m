Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B611296BD5
	for <damon@lists.linux.dev>; Wed, 25 Feb 2026 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002123; cv=pass; b=cfBCWid5Eqnq4TfUYsIGCOCy9i2Nl15w7zoSdvKa7FkkeMjJhS8+h+bASLonHjnrkA9txC3IxSWCQ5jNG+r9L48QqR08AIO6ElsaVeuNscVGIXmdV3n9ELOzuH2+OQ/j6zzEcGc4wDrvw6hX57M7pOKrRyARYdGNZ+1cdBpdQ4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002123; c=relaxed/simple;
	bh=bazJDGBGIMAUx3oqaC9l1I5+Jf0tEIuN88T64t3EkHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxFfqmddQABH6Dx93R9tJtaqG2AGulpwBW+A0HVQXjmNSyw22F0oqN0fQA0NYfoZz0kQbF4afwMH9RoIRjwJvCHEr4DHFVOK+J7Bn1iD4sfZl62wE6hPV/uIHmtzeGxHEpjLyd8/gcBJ+XRs3cXKmkrfSuRoflHWu+lxDWJ9kqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTHwEBT8; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTHwEBT8"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899a2f4cdddso20612686d6.2
        for <damon@lists.linux.dev>; Tue, 24 Feb 2026 22:48:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772002121; cv=none;
        d=google.com; s=arc-20240605;
        b=YFy5VvVe3OFpNsjg7BEAgl6ceXc1qxO9nIKdsbPQX1wsIDXomodDo3aVMh3lGZL0Rl
         IHRqwimbzaoX8++4Z+oEuO3HRCjJYuyiHY+GSmYe+R0WeqIEB2prs0SE4RN7Ck1NIpyr
         huoEFLSKGewAKN70BQkYHmduZyvP9raZhu6Ds+sDMygdRIBxy/5lAypX0Ni18Vu5dUbO
         Aw0JFWnnbIVocyQIrWH5306aed7tjTs5gxExsgYnUU1Q7C9ZHxAMtAB86A35OyzV7PgH
         oanhMhC9VUxoiLdHo05qcZIkUSLxfpC44CI6csirpvzoGR9rPLoZ2z9GmLSEKhcUmq+n
         PZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/snVLuY2V+3oJALazjxJR4aATI9prwsZ1+qFFk8MT3U=;
        fh=AmWmTaoxbHcw5/q57jVR1Bd4OOiRq+J7r9gV9vOm4BM=;
        b=W0D95o9SRXfBWuiKK/D/ReEbFpEBf/JtXQppT8s7UT7/sIXuVgswT0D0U1YJHX3+hh
         bWWhLrweJch4WtRBHIMKD5AG36IuEcq9hSypQVngzzpTm9HpP2Vbb7kW55UBvy/0XK+t
         2Chte9GF3ai6zLt6/H6jeKnTJyfcb0z+PzPAi5ytO+3J/9tuVOGUW2rw5Rn7wCrbnw9i
         C+M2S8gYkG2TIngjXhSQEmzE6ek3pP9TxD8AvWFzafw7tPmRWczgaeKb98bbztOEyveI
         kUTeRFqr/K4QcipPqsjJBPfYqwmlv17gFk1KQaywjNkh9bpiNuVEw3BMGjz+VmFpa6Ti
         dxjg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772002121; x=1772606921; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/snVLuY2V+3oJALazjxJR4aATI9prwsZ1+qFFk8MT3U=;
        b=jTHwEBT8DnDTzvz3Te3DRE9YXIe/bTToFsPBkCABtvE8ZLIiTdb/60kkYe9M+DfRdf
         lu5cQWmQAgpG/ZYkFZcxCvd0h8BpXx9m55Q7P5g4eb39n4vh4US7Y9v3BFe5JbAZ5yDX
         Ep73y3fV2oFs0WHVCrcMyzKL6lyFjUrcdUvCzBAYCUVlv2rm0fUSlO8fH6LA9ZHwk2iG
         myIID8IbhRJohTncHa0bIpEu64DQ34evPdBlXT0Io8Ary5TMvX3pe//fZxk13M5kH4ah
         Mo4hGBhCe0BlMgxweWHwxHqtcuhTXJFfVicbVVBNTsfPuRipg7i0bPRZM5URK2XNFjAS
         OdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772002121; x=1772606921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/snVLuY2V+3oJALazjxJR4aATI9prwsZ1+qFFk8MT3U=;
        b=AUfjhW9gbiQ8k0MwpR7ecxkrrQfqNKwGSGtT9ymQZyW5LUU2heDEp4Hp8MiAhqf1x3
         R/GZHrxgtfnBEOn0ldHiycub7idhkiN+QYKaZhxoXoahzV3IUe5OWv/PNdaYGvjbjQfw
         McCSJbxftkgjNFB5UZXIQ2AJM/X42gkn3TpV+8Bapaq/2m+2HoM9941m9ydbjdhv+ynx
         61jf/GXmjYN7YfHMvv9qrlbszGDPsLwXHUne/a2rhDuCwsyxkwv40aVTwyyClukWbVo/
         +u4ilSjPmU+PruQsDRSH8hsES2HRuRy7WsSyO5Vz12iifhW2URpvUQQjvpRAEK4co8W2
         ZI/g==
X-Forwarded-Encrypted: i=1; AJvYcCVsMCQysxfdabEnyJUu6io9OV0a+AF/noFEYm+uSYmxFvJC9WolaD3X2YSHPPbMgVO602RWpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwduJt8PkmjO208owJGtOoQ0BRJILJ1DSMkwkJ4WXY3i0X45E26
	5RkEW/Y25f7Fqd1JiO86vQBLOQeyAuSTcbpZzgXzMH8mQXIgldDioFsh8bTp2X9ta5oL9FWTdTy
	ueQD7y36mYNiZGonfMZKGDJcK/37RGzs=
X-Gm-Gg: ATEYQzwefIyRDAadxMkv9IsZNzWLH44wmBesRNy0VEVsKrUt9F4eH+i5y41YyFNqUbI
	rUvfNHPhVNOmv4sd4oVbe15fW8kZdphbsDoFEj8dQy/D+KM0XjOaMZbehPQhOd+6jkLpfH44F30
	1vRPLOV5KNpFUUdgS8NzR5VRd5vaZXdWP1L3xYHYAkhkDNt7watE5imG1o91NjmTYDAzQ1xrp5E
	xQS+uQnRE7qLHHKuHyCnovYVeIi5ly9ny9FnUmx0FOHV9L06Lw40CSk3Uaf6Sp1+Pm05ObqBCH5
	BFYkEy3ElKOOTvkpLVT3ta9Q7rpFC2Mlja8=
X-Received: by 2002:a05:6214:2aa4:b0:896:af26:e74c with SMTP id
 6a1803df08f44-899b8c39dd7mr17449006d6.56.1772002121092; Tue, 24 Feb 2026
 22:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260124023917.78649-1-sj@kernel.org> <20260124024804.78869-1-sj@kernel.org>
 <aZwLDAxf9eP0lPdD@z2>
In-Reply-To: <aZwLDAxf9eP0lPdD@z2>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 25 Feb 2026 15:48:29 +0900
X-Gm-Features: AaiRm53GGaPVVDHoIKhwqeCV3u1Grhep-JVfBKu17G30DWV7VsMshswA2-jNLxo
Message-ID: <CAC5umygJNCxbDwbTPc3FFRAO+sfHyxx=QSXXF9g2TSiQ4Bvw=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
To: Namhyung Kim <namhyung@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, damon@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B42=E6=9C=8823=E6=97=A5(=E6=9C=88) 17:08 Namhyung Kim <namhyung@=
kernel.org>:
>
> Hello,
>
> On Fri, Jan 23, 2026 at 06:48:03PM -0800, SeongJae Park wrote:
> > Cc-ing linux-perf-users@ for any comment from perf people, about the us=
e of
> > perf event from DAMON.
>
> Sorry for the long delay.
>
> >
> > On Fri, 23 Jan 2026 18:39:20 SeongJae Park <sj@kernel.org> wrote:
> >
> > > On Fri, 23 Jan 2026 11:10:10 +0900 Akinobu Mita <akinobu.mita@gmail.c=
om> wrote:
> > >
> > > > DAMON currently only provides PTE accessed-bit based access check, =
this
> > > > patch series adds a new perf event based access check.
> > >
> > > Very interesting patch series.  Thank you for sharing this Akinobu!
> > >
> > > I only took a glance on the patches, but my understanding is that thi=
s series
> > > modifies DAMON to be able to enable perf events of PERF_SAMPLE_ADDR t=
ype, and
> > > utilize the sampled perf events in the perf events buffer as the sour=
ce of
> > > DAMON's access checks.  In more detail, I understand enabling PERF_SA=
MPLE_ADDR
> > > type perf events makes the perf events buffer filled with memory acce=
ss event
> > > information with the access destination address.  The event will be s=
ampled
> > > based on time (e.g., one access event per X milliseconds).  And proba=
bly that
> > > sample data could include more information includign the CPU and the =
process
> > > that executing the sampled access?  Please correct me if I'm wrong an=
d add more
> > > details I'm missing, as my understanding of perf event is very poor.
>
> I'm afraid you need to deal with PMU hardware details.  For example
> PERF_SAMPLE_ADDR may not be available depends on events or sometimes it
> may not have valid values in some samples like on AMD IBS.  Also hybrid
> CPUs may not have same events on both CPUs.
>
> Maybe it's better to fix which event you want to use on each CPU
> architecture.

Thank you for your advice.

Is it possible to get a list of PMUs that have the ability to get addresses
(PERF_SAMPLE_ADDR or PERF_SAMPLE_PHYS_ADDR) from the kernel at runtime?

Or is it possible to detect that a perf_event initialized with a certain
perf_event_attr does not have the ability to obtain the address?

> > > And one quick question.  Can this work on virtual machines?  I'm aski=
ng this
> > > question the for following reason.  I'm actuaally working on a simila=
r project
> > > that extends DAMON for page fault based access events sampling [1].  =
The
> > > project aims to use page fault event rather than other h/w features s=
uch as AMD
> > > IBS or Intel PEBS, because my understanding is that such h/w features=
 are not
> > > available on virtual machines.
>
> KVM supports PMU virtualization.  But the existing vPMU support has a
> lot of overhead.  Recently mediated vPMU patchset was added so you can
> try that instead.  You'll need to pass appropriate options to qemu.
>
> https://lore.kernel.org/lkml/20251206001720.468579-1-seanjc@google.com/

Thank you for the important information.
