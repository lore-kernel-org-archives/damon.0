Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5029267B90
	for <damon@lists.linux.dev>; Wed, 25 Feb 2026 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043805; cv=pass; b=oZ7KjgVXOxSbRU8nu8nca/VFW252HaYmJLAgbcbKVhbw+7mvYYOlJZCF00cV0sEYvoVEfEWnqFLKHyxSfQknVuKScUMh9xRcBQC4PJUCnQHBpnvUQ4DlRkwhmkYBTZiVeuEa22v25NK7hg1c5keFRWlt10/7l+WHHHiqvO+7BG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043805; c=relaxed/simple;
	bh=5BAMHytd4kvzuUgndcBud/UrnLOdHAgpwSexbphb5p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3f/GgTV9SMEm3KFAfFxhcbWYX/9/SlS5qgmAbGaJAGsKTUFJW2Gh93u9t0TqonEB40PPboO/ePBhMJ5kjP5Q6LQDwGeb30LEHFd49dvJcmmrcr46WjNezo+8J8GXKeb2FHp2H5v/YCXAJP+aFiZUiTjOOhsfLWLEXcERttsCKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRUBUeTI; arc=pass smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRUBUeTI"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-124afd03fd1so10101144c88.0
        for <damon@lists.linux.dev>; Wed, 25 Feb 2026 10:23:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772043802; cv=none;
        d=google.com; s=arc-20240605;
        b=OqVn3eO63krp9vEDH2fT0o6bVFxYMFX7XE6s0m0IIAiKPBHklRZOPvgEdu0wKpg6/0
         VfU6+DevKEMLyaA9F2yOPca47WcI+g95QoETSFgdVu4RgZnWhc9aYYOxEd+GxxFpkNha
         fBc+Ksfp1qx+2NgqtY/1bjIMHa/sLZRQ/O322yvV3oRXtHRy9+hILTvQms8jYp8i+arw
         +HGfznl5rIrRWGsRxCiFLa5hL69JDzbcELEmipPxGCtALwxvKsNxs4tZBTlTRpFN8Dmb
         IIE1xCMKzhMCHAZZOY/F82SfOL3mfQIo4S3wm3/pLP3bTIAVnyze2w49/+8jmmpxIhct
         xKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/xa2NxgBV56+zcp+pDI4D3jQAyDOvWbrM47gZNUvrNM=;
        fh=g3VMvJQux/HSLIVicncr24svuVPzuNK+KAx5AQfJAks=;
        b=GPuDtEIt5qkzR/P7RKB7uIm5hFhuMUxIKwPno5WMH7EShByC6ckPN+hp6XZo4hJImo
         aLSw2W21l67ZvtYw9LueYDS+LSiNIKLOP/vVfo0d0fn/Z+Ksrw2jMNal33/161yGM5iP
         zFr8EWYmB8amtx340Ni43ShoCqqFctfbVkEL2YzWu03GggDVtf3F5rosz2d2dB/NIR9u
         0ibgLc1PpBfOXurrDCMUgVj03khioWNQv98dxmv0CxEahUr93rxyLxf/tA/nR3iKYTHO
         rd+cGrnqJcm1rTnBB5zbwyQUWX5a6/Vo5CQ+NRYaI2ZYSbQ7g+5unnkdwhVkqiS5Rq53
         4r0Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772043802; x=1772648602; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xa2NxgBV56+zcp+pDI4D3jQAyDOvWbrM47gZNUvrNM=;
        b=DRUBUeTIBrgZyIwfsgS174sjHvzqtBN0csjmz5cXReLOU43TqzDl0Yo5remHCFqfhX
         eGDz4gMXJdDdCL2Ylb1WhubX2z7mnxPSINN+q2cjihd7IJskcF+KxiFCT/0HHB+xakaM
         EVAEv8A+2nVfMGcVPK2a+6m4k+35uZhRJnvvYGlRi/ffsuiuD9OM9lM7QhWxdPZ2kjTq
         R8yGyV64bOH09tTyddflYHs1r4Q2nnvHtdQM61LbEwQnalPW8mCIHbKGYZfni6TIwyBz
         zGCMQLtZC9Itv7aVwJ2o05nhNeMdn2Vw4xq2qqCzQIJi83jOgpmU++g/YTexxB9iGxZT
         JZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772043802; x=1772648602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/xa2NxgBV56+zcp+pDI4D3jQAyDOvWbrM47gZNUvrNM=;
        b=wwvjqd+3KcJ/EATHnUR+lK0VV13KQiu2WI3GxF7QKo3/EVX/HPxGQcMt7HwqaWHm3e
         W9qvcxsrZ6goyoVE5Ll0Fjo++eY/YmpLu3Q84/57UGJHclZKi/U6VSnsZUlRUg7PcIBv
         0V/T21rlcLb3IFoRTYkimQNkD9UhRvgfe/meNAM7P16Y33iGHgqvjF/mW+Zc1c0+IwCS
         8rjx3h+VvcTVA/grY0jSDK7kNRyVArFsrS3RVI5je8lWyhQuUTBueh86hDPnAJdDlMIy
         wK7LPaGRY2Gj2U2nto2/4eFLsGoVDY6YOgKyGrR5hZRKRl1JeNaevQn3+VXcYa1HYRTb
         O8lA==
X-Gm-Message-State: AOJu0YxkMQJkAKEViXA90etRDCiO98nMFMIWcL1UTfQP8o5c6qUIGnoQ
	qrjTGXHoP4xe8CmywMTjEMbFxdqt3W7UhFfKwjraciBRQ6/qjGXRKzIwJBn0pPwmDCNuDL2j4gi
	3XcQvAnJbciwqch98mF+tcOurddq0pRIdJG0tX9qc
X-Gm-Gg: ATEYQzzWOnwYWp+PY7JWG7wJAOIGW5GT3YacEGnXynTPPdKgh9F7IWX2krhSp96zTn0
	G++juqAaJO6oyFmJfx6Ea9CQyem5U4AQPz/u0x+w/pRVmpywm5maPfrSzGO7Kd8QwFO4ySM9zNO
	EFjrZokiReWjXZPDoWtjdgF7XKp+rLG50KinGtHHpZjzFA1WfR7M92zRmZzgf9kyoGmL1IyG7S9
	epvwBYTKZaXWHY+qAN5C22X+9mkYFtbr8l24T1UMMd3rSLaWWG/CgY4++NN0pfWH5GwPecyTuY8
	ZLXxfjQ=
X-Received: by 2002:a05:7022:1605:b0:127:3214:c862 with SMTP id
 a92af1059eb24-127869c8215mr555717c88.40.1772043801261; Wed, 25 Feb 2026
 10:23:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260223123232.12851-2-ravis.opensrc@gmail.com> <20260224014011.56624-1-sj@kernel.org>
In-Reply-To: <20260224014011.56624-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 25 Feb 2026 10:23:09 -0800
X-Gm-Features: AaiRm52SmZr4YLw7ydgp3VDu-h8ez3jJibjPYgTRa_tIkzg4tH3npe4ZI2HnusQ
Message-ID: <CALa+Y15MQecahb-FfeQEJK2uwFdC7VxUH7GHCfSvy3uQ_jNC_A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/4] mm/damon/sysfs: set goal_tuner after scheme creation
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 5:40=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Mon, 23 Feb 2026 12:32:29 +0000 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > damon_new_scheme() always sets quota.goal_tuner to CONSIST (the default=
)
> > regardless of what was passed in the quota struct. This caused the sysf=
s
> > goal_tuner setting to be ignored.
> >
> > The comment in damon_new_scheme() says "quota.goals and .goal_tuner
> > should be separately set by caller", but the sysfs code wasn't doing
> > this. Add explicit assignment of goal_tuner after damon_new_scheme()
> > returns to properly apply the user's setting.
> >
> > Without this fix, setting goal_tuner to "temporal" via sysfs has no
> > effect - the scheme always uses the CONSIST (feed loop) tuner, causing
> > overshoot when the goal is reached instead of immediate stop.
>
> Thank you for catching this, Ravi!  So, this is a fix for the RFC patch s=
eries
> [1] that not yet merged, right?  I think this fix is better to be carried=
 with
> the series, and squashed into the broken commit to not introduce unnecess=
ary
> regression.
>
> So, if you don't mind, I will squash this into the sysfs-schemes part cha=
nge on
> my tree, with your Co-developed-by: tag.

Yes. Please go ahead and squash it into your series.

>
> [1] https://lore.kernel.org/20260212062314.69961-1-sj@kernel.org
> [2] https://lore.kernel.org/20260212062314.69961-4-sj@kernel.org
>
> >
> > Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
> > ---
> >  mm/damon/sysfs-schemes.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index bbea908074bb..fe2e3b2db9e1 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -2809,6 +2809,9 @@ static struct damos *damon_sysfs_mk_scheme(
> >       if (!scheme)
> >               return NULL;
> >
> > +     /* Set goal_tuner after damon_new_scheme() as it defaults to CONS=
IST */
> > +     scheme->quota.goal_tuner =3D sysfs_quotas->goal_tuner;
> > +
> >       err =3D damos_sysfs_add_quota_score(sysfs_quotas->goals, &scheme-=
>quota);
> >       if (err) {
> >               damon_destroy_scheme(scheme);
>
> To follow the order on the comment ("quota.goals and .goal_tuner should b=
e
> separately set by caller"), I'd prefer setting the goal_tuner after
> damos_sysfs_add_quota_Score() call here, if you don't mind.  Let me know =
if you
> prefer keeping the current order.  If not, I will just make the change wh=
en I
> apply this to damon/next.
>

Agreed. Please make that change when you apply it.

>
> Thanks,
> SJ
>
> [...]
