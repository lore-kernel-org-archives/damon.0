Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5511C18E377
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751420641; cv=none; b=gYETQOwuw45t8vpgbFyVSt9JDsa9t/rnB6QOIFcmybnXLa1d3Vsw5wUky8PoYr/xfxiw4SR9nWTG6bZAZxTYrfMxoyh0IWZoXs4qi66obYrmwI7Ilh+z/0aCbge975oEw3k5rxka5KO0p1xYcRmF4lKtOSjXTN6X05Eu5fWpXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751420641; c=relaxed/simple;
	bh=Wp3QvUmtjaYbsboLk6wHkkZX7o8yd6hDGDrdeUnpK9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/OAxCa1UzPocOo2XmD1FKde4dDVbVmDHWWfG+PyybSr4d49XsPG6C2lBlMIyHUxdNNc64h1XQIy4Ul5N7RrE75vi9EvnEJibXJnyJDZV0qBnPBhX4u2LKjmLR2W1DXlItRmNiYMs1owiak30Oyb9pnTaRjgPtcQa3pf0ys7F+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBQpDg2C; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBQpDg2C"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so667490966b.2
        for <damon@lists.linux.dev>; Tue, 01 Jul 2025 18:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751420638; x=1752025438; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1n8DQ3QrTUlCt/gae0hvfHO3lvru66RPSduUSFUq30=;
        b=cBQpDg2ConEBFV0RnudE/Hq9XAPGp84hawcrqcfZHhqO88G0ehFL6cpqItJTlqfhJG
         b8dHF5f15Re+WY14mn7m7b74h9fQ+yE3DHgsUgnFWVCGTNJLhR+G2htYEZGcLwGqt6Ve
         /5ryAAIANqcxdN8eovcjNj9RBwDIwScxXGjkLzrBfvU37w6dhD88/VVmyDkf1JNDyazA
         FLFQppi9/UzcfdQNGlShfDQ9Pl7aNV8U0Ak5r5IpRVcJI860oA6pOkEAXRqh5BE8fZbD
         LM4O++Ga1OhuBq4KypMbi1LzDKeqkYjOdYzl74G8U06cTtITtZMyEelCaOL68K4oU0Dh
         Szfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751420638; x=1752025438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1n8DQ3QrTUlCt/gae0hvfHO3lvru66RPSduUSFUq30=;
        b=pJ/7tXao9FWXuzmzwAuJ7hELQQz9b/ph09BGxQDdhVvrD1oQZo1OBaG86+6vf69XLQ
         gSBWIhTpVwDu2UPHxZfD3cLg9OPZIlFMv/cfX8rNID9KLrGcCi2RNuJ3tILWPN8/DjCe
         LPADgw7YFaC/i1hgo1YBRoeLSy1QDXKuJnJM7HI2kbEWv0s2rAlIJgJpqc7KQXqVIP9J
         KM5Nwg+nVXNsB702fcmIgnxvYF8AEtxaRQLOshUXQpOwT8mCc4dTw4nrkZXtjT/xUxZP
         AbNj+9CIeJ/Bes7jEQavBA+Z3Jh4tpOLSvGkCr3ZSZQlXgUxiszzVtLupfkTpyiKbk3x
         JzGw==
X-Forwarded-Encrypted: i=1; AJvYcCXmf9uk4KwPNz6B0ih8haBMSfQ1gqCruiVT/0R3gXE2iQw1pPkLYxpdKu5ApUuhok+6Vfv7iA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2XkAXxp6KECYzas8CeyKaA5UfxInQs2UaIltRARzEXn9xrTKI
	Q8zaU1doVtOWTvhcAg9aGZLwSeOlLrcFlKvjKGQzzz2bd/FZ5+t+J4VMKQV06tqyd5teB/rGmUd
	44nldrh9XMPM/ylFhkG0Ye+QS1PNSGko=
X-Gm-Gg: ASbGncvfWvOTK6HGFGu7tN/vdNqS7diu3mkuUux7xP26OJG6H/ckuQc1atbfSNFq8aj
	rqhJlo280Q3MMplCm47mQeuE//SrikTzPDN71GDLThHOuVkXP9oh33t6zXsJmb0qUEWi6zFtg6D
	XZlCTdjvl3o/JLv/Zlp9oomFmruqYcKN/TBTjseoxttSRMPV/PtClaNnEjHCoQa4MNQrDp/LxQr
	jw=
X-Google-Smtp-Source: AGHT+IFFTFwxg9s96AHZYDv0fsyMNx/xRNvBJ980ERQ6xN+1W6v2zN2Ey8sVOwsKieogYMjNrfk0YEpZRgqUf+eTgAE=
X-Received: by 2002:a17:906:f592:b0:ade:484d:1518 with SMTP id
 a640c23a62f3a-ae3c2c04018mr85819566b.26.1751420637499; Tue, 01 Jul 2025
 18:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250701224353.9062-1-bijan311@gmail.com> <20250702002551.1246-1-sj@kernel.org>
In-Reply-To: <20250702002551.1246-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Tue, 1 Jul 2025 20:43:46 -0500
X-Gm-Features: Ac12FXzA0rgJUVRIyV0Ugx-F7zOyXIR5treFqwmb7GBsQKdrPT3I4LC2ikATSL4
Message-ID: <CAMvvPS7U9iV9K70-4J-n8pKLVBhY3Hfky4Hc3dxAbzVE1o3oeA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] mm/damon: add struct damos_migrate_dest
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Bijan Tabatabai <bijantabatab@micron.com>, 
	damon@lists.linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 7:25=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> On Tue,  1 Jul 2025 17:43:30 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> > On Sat, 21 Jun 2025 10:31:28 -0700 SeongJae Park <sj@kernel.org> wrote:
> >
> > > Introduce a new struct, namely damos_migrate_dest, for specifying
> > > multiple DAMOS' migration destination nodes and their weights.
> > >
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > ---
> > >  include/linux/damon.h | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > index bb58e36f019e..d60addd0b7c8 100644
> > > --- a/include/linux/damon.h
> > > +++ b/include/linux/damon.h
> > > @@ -447,6 +447,22 @@ struct damos_access_pattern {
> > >     unsigned int max_age_region;
> > >  };
> > >
> > > +/**
> > > + * struct damos_migrate_dest - Migration destination nodes and their=
 weights.
> >
> > Nit: Can this be renamed to damos_migrate_dests?
> > I think plural fits better because it stores a list of destinations.
>
> Makes sense, agreed.  I guess you will do that on your own when you add t=
his on
> your patch series?  Please let me know if you prefer different ways.  I c=
ould
> also do that and send it again as RFC v2 of this series.

I can do this in my patch series.
Would the best way for me to do that be to send modified versions of
this patch series with my patches, or should I send one additional
patch that just renames the struct with my patches?

Bijan

[...]
