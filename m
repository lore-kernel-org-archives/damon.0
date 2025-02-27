Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67FE25F7BB
	for <damon@lists.linux.dev>; Thu, 27 Feb 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670515; cv=none; b=cwuOKa4v92VsKK6f8B8XYHsdjk3E3ohTSImRWRlYAVMnlhnCxh7iD7gsyfS+4YkoQAVcsjOQL8if6hRFl0tuT0ZZObYvm8YpPMnR0U/jgBu2ayEJB3mlgaVahmdGWYdeGu4WWtzMwsfxJimm7qrDU/h1M/qxq9ZnxEc+dryGpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670515; c=relaxed/simple;
	bh=THOgoUCPQEdt7Oe3vGYp8azSrWCOlikK8ngknxVD1fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usspNUZtO4rFrapni5VMK1L3ww9U3TRnp6PvcSbJkRtTEGmOUh7/v4z6zkJDpmyunp6CLQFL7uy5SbfMUOqBdSb3Ub6a26bDfrcf/uvuJguGq9RZ5+ukKIP+W6yXjzF8gVVW4b85a7+mufvI1eJeFGCKubj8jVhaYvQPGVqhFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GffRQs/s; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GffRQs/s"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54527a7270eso1049331e87.0
        for <damon@lists.linux.dev>; Thu, 27 Feb 2025 07:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740670512; x=1741275312; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJAVQXLJF41TwKPGAbCYXhqrLx4dqXncJmXzY8Kudhs=;
        b=GffRQs/sw473gKdvFSzoR6C5/ZmHa0+sRKrDQDgqVzv+A0HIhizUkWi0YJyKK60401
         ImpiWRDySQe94vhAzq3YTo3PS51V4NF1pHLusMd5KYNJQjvA26+aKI4BFQhZariQH/18
         leyoqcZTR/fKUQ20KJbLPtpEmbTo6hyWGDTpkVn19NK5MasNWdPxCqgiVvZ2q48y5POJ
         AWou5MSt7MWpM0FL5sWxLbnjCkPGodmWSVQad/FURkaniOOC8nKko4dsRCr3NseQKdnE
         PmDc40sSauRuFPC4ltDnkSWpERdfc3D95lMnP3QQ5L4cbjJtFwyjYW6Dejtkj/uoM8mU
         r1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740670512; x=1741275312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJAVQXLJF41TwKPGAbCYXhqrLx4dqXncJmXzY8Kudhs=;
        b=PFKpYUCRs1vpNYuGUqe5x0A4ZTwL1BSXYJ1bFvrkzccrrkoifCc7Wp6MNheI1suP95
         e8oRPK9jq0+94fxVDA5kcnYOytPCfp8P3qEqObJvSMy4cKBefU3LuHKH2LhXi3m4L+6W
         Y7vkJRI13UgtHs9eMk+KIK/xY6j7M2Rl/FYJtPcWLK3d1bW2U0jngByUggUcoC6t6P7r
         UcyZVFkV7nAg6ETCnstZ0AKbGP7K0eiSN/vycX564HOWTRFyOdoY43qs89/sO7npc+BR
         8yZsuTJVE3gaLIiXr4H4SdTG9e0xOFHL/W0q+pwPI/JYY2dxtd58o0bNVl0jPEPnUbYQ
         thXA==
X-Forwarded-Encrypted: i=1; AJvYcCVoipSPssTlCegU4VmBOXhzp8SyyUx0SoxUJsAghu4M2STh2pJk3vCicLaRzh07TkA6eq7KXA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy38hSxbfMYQsTBjPUfaxPED3mAK1nWx/TNudL4L8PcVADoP/m8
	ztaAcO3v/46RUo3SaFBi89LBJi9hrt3SbNq7j4lou7BG+TKj/LT0WeQI3knC4FRAF6cCdiFXuXy
	SVAtaavED5ZRGXNkp8weFmJPNvNY=
X-Gm-Gg: ASbGncuRTLnEf98TfP/bGm4NKeE7RdE0M7EeF/XBVotlCk2dPwEDLG9xVXSF0kmsoS4
	Mh75iZ8soeIjy4GmynNz54ASQLleSi7NNgruRCKOyovwLXutRkXU/sS5wjE7xXXWJT6QFIkrBg5
	YCiJg65F8=
X-Google-Smtp-Source: AGHT+IHkioLSrJ+spmAVkzxsOQKumBkTuuyrkNOUQFzsV1KMTNbozWKdNRWZKXkA2/o4oBp7wYg8ktbccLWtdz/oMp8=
X-Received: by 2002:a05:6512:308a:b0:545:10bc:20ca with SMTP id
 2adb3069b0e04-54839147d25mr13703939e87.24.1740670511542; Thu, 27 Feb 2025
 07:35:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250226133703.3c9775c9e50e198abc9b9f6e@linux-foundation.org>
 <20250226225605.2000-1-sj@kernel.org> <CAJGd785Eu7iuVwYnewaUm38NJcKzB-xkZwdRiYR9Yo9Qwaoffg@mail.gmail.com>
 <CAJGd784+kQ8NXSp1=9tZW+4wYvTh6SkW7ySaB0TVGcinjjcEdQ@mail.gmail.com>
In-Reply-To: <CAJGd784+kQ8NXSp1=9tZW+4wYvTh6SkW7ySaB0TVGcinjjcEdQ@mail.gmail.com>
From: bus710 <bus710@gmail.com>
Date: Thu, 27 Feb 2025 07:35:00 -0800
X-Gm-Features: AQ5f1JqUz4ttcsCrVT7lObPG6DvWRZ3OCO3KBiTMyelf27g9p6d60kOIKH2WNB0
Message-ID: <CAJGd785bhaXV4=R8dL-yNdQLN3YsJL+L+XQH3jwqYdYCCy5LNA@mail.gmail.com>
Subject: Re: [PATCH] samples/damon: a typo in the kconfig - sameple
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I was wondering how others live with the git send-email all the time,
so I searched for alternatives.
Then I found out that some people use terminal email clients like
Mutt, and learned that the inline patch is the right way, not
attached.
Let me do the inline patch if there are more chances in the future.

On Wed, Feb 26, 2025 at 11:03=E2=80=AFPM bus710 <bus710@gmail.com> wrote:
>
> On Wed, Feb 26, 2025 at 3:07=E2=80=AFPM bus710 <bus710@gmail.com> wrote:
> >
> > On Wed, Feb 26, 2025 at 2:56=E2=80=AFPM SeongJae Park <sj@kernel.org> w=
rote:
> > >
> > > On Wed, 26 Feb 2025 13:37:03 -0800 Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> > >
> > > > On Wed, 26 Feb 2025 10:42:04 -0800 SeongJae Park <sj@kernel.org> wr=
ote:
> > > >
> > > > > From: bus710 <bus710@gmail.com>
> > > >
> > > > Full names are preferred, please.  Actually I think it's "required"=
.
> > >
> > > Thank you for letting me clearly know this.  I'll request full names =
to DAMON
> > > patch authors from next time.
> > >
> > > bus710, we could still update the patch before it is merged into the =
mainline.
> > > If you could, please let us know your full name and if we can update =
the patch
> > > with that.
> > >
> > > >
> > > > I'll apply it anyway due to the patch's minor nature, thanks.
> > >
> > > I agree this is a simple enough patch that the name doesn't really ma=
tter.
> > > Thank you Andrew :)
> > >
> > >
> > > Thanks,
> > > SJ
> >
> > Oh, yes. I was a little worried if I added too much noise for such a
> > small work, but I shouldn't miss this opportunity to leave my name in
> > Linux history.
> > Let me prepare a new patch as soon as possible.
>
> Hi all,
>
> Please find the attached patch.
> Based on the latest one, from @Andrew Morton I just replaced my ID
> with my real name as well as updated the subject.
>
> Thank you,
> Seongjun Kim
