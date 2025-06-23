Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91439132122
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688851; cv=none; b=N0e06QB+5zQ0tn5C6KreJuHKrdhFaWGYQBjs6TNoLdjDK6Vq8X57sqXjPonzyrGdClGhvpxT+xTibsq24j1MUEWDHJjG82bu2bbwfvleXwIzc1coYL3LTgGO/zcep9dtGXoejVR3sYN56sE4s0F69VQdABG2RlSMeL/2rp5bGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688851; c=relaxed/simple;
	bh=mnIK+W5KngtwZhVktOKMz0FyAthSv5HiBjAvWwmaW9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feUyPb55yg/B5TDEvGnjfiM2yjEzVzqo0/EMLdKo4rmwicy8oVBGInf30umusc5HFAJWgex6yUrb6AGjmCB/uCgxlL+TofS8reKdCKU+r5AY/RjBSeF80pguE0x6YgXxY8s05T31jRx39H2Y0DjAPp0dpjHs6e3e6lo1f4GSRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/irKkY8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/irKkY8"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade326e366dso783610666b.3
        for <damon@lists.linux.dev>; Mon, 23 Jun 2025 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750688848; x=1751293648; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mxmuO90Mgrv1homANIMZ/x/S7lf2iuPtj/uEFpEqR0=;
        b=W/irKkY8+9wvwMU/6Xo1oe4lt2MymgtWYHgET4D8VxpBN3tFOe41xqz/xMf0rgzUCp
         AXlXMN6OcKPQ4dTd9BqCvCxWVmsTxjp61SmL+7995518YkVK9as5xtTKHfTGbktmm1b8
         hqWlDK3P4y9pnjF8IJqC9eYbNN5jR40rREj1cvB7gVnnndQTsbaVJwWedb5wOPuH3uFM
         3iuEThhM9J1U/nMNUL5iVrDfYHLIMnEerSxi/aPrN5a2PfT+SRYKfFzURuYfZW5AtMr/
         7Yvl+JCnIymzCqP7UJ+/uhzVY6N+r/1rjlH4cWjmAuljVfi7wCgIaW/H2/pRyjfslfr7
         Lfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688848; x=1751293648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mxmuO90Mgrv1homANIMZ/x/S7lf2iuPtj/uEFpEqR0=;
        b=n6HSg9nA6tkiy96EomK+VEaJdNpDYcK8LjVKrnRqBKQI03mJyH2mDJ7AXnQL8XB0Y6
         JddJZb9VwT97HXjvS9BoqC7ci7B5vtuGlcPWN+AV3qubeMqefTcpObQi4RzPLQFlag2L
         nq4kWiRcxXcceeSsO8FNdIdcvap/WbQOCSSc6/wQElaArrYTAVoY0wdbXtlqm1K5WBr4
         SsDjtByGPSMcPGaI3xMCqzb4lh2sFba0bkzq6BkaKwALEW/SyD4oH0T+4Y3SdKwX2gVR
         57bqa3lyQRqsPppHF7FVvGILNifc//7fpTr3QwfOHkL3XtIzBv7w8nxCyIONvZJGAvlt
         Cn5A==
X-Gm-Message-State: AOJu0Yw33St5ABTsA2+y3UFQkJJE/k45RuNtC1ueu04V3juQloucAEeL
	MtxcCYeUxMB1itgv9bZm0lNtwa3puRqYGzfVzMk2JAS6nNONLK9CopKQSRQCl3hsaFzWht9xUBs
	PTBzofb3Mem2HPh9WpXi0rZ6krF9M5fg=
X-Gm-Gg: ASbGnctn+1V69JzxPch1UVA3lC4BRpjnkXzzKE5aiHMAncdQ/OIWvYxMDRBXdYAdKD+
	HIPs6CkhSOIJEOjCIBBmp94s6XMyRft2mQGW2x9OxtNIdfDXvDFwGWQnTciJscqnnmvHdInFxJh
	RLrOjxAweEzERnu7oS7878cGA87nZ/47aLlANi2eC15qmWT2+XaO96SA9/HuDamoTtGpgn5cOgT
	C3dzQ==
X-Google-Smtp-Source: AGHT+IFg5WdPq/qtv4lksfp6KScFWAG840JHC2XOEBUW7uElx1+hH2peDn+CU3J7X0rKpYK4v7bpx2FOMkfNnjWA/wI=
X-Received: by 2002:a17:907:60c8:b0:add:ed0d:a56c with SMTP id
 a640c23a62f3a-ae0578d9c7amr1099129266b.0.1750688847762; Mon, 23 Jun 2025
 07:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250621180215.36243-1-sj@kernel.org> <20250621181127.36394-1-sj@kernel.org>
In-Reply-To: <20250621181127.36394-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Mon, 23 Jun 2025 09:27:16 -0500
X-Gm-Features: AX0GCFu6T2Sb_KHAJnfSsDjk8-dMwbeEOaowGMMnJk16KremJtvAzwu_az7M350
Message-ID: <CAMvvPS7ozBjY-YWHrkkGVQA8ug=0=xT=BeyZxi0YrHp6PNQmHg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] mm/damon/paddr: Allow multiple migrate targets
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, bijantabatab@micron.com, venkataravis@micron.com, 
	emirakhur@micron.com, ajayjoshi@micron.com, vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 1:11=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Sat, 21 Jun 2025 11:02:15 -0700 SeongJae Park <sj@kernel.org> wrote:
>
> [...]
> > I'd hence suggest to implement and use a simple weights handling mechan=
ism
> > here.  It could be roud-robin way, like weighted interleaving, or proba=
bilistic
> > way, using damon_rand().
> >
> > The round-robin way may be simpler in my opinion.  For example,
> >
> > unsigned int damos_pa_nid_to_migrate(struct damos_migrate_dest *dest)
> > {
> >       static unsigned int nr_migrated =3D 0;
> >       unsigned int total_weight =3D 0;
> >       unsigned int weights_to_ignore;
> >       size_t i;
> >
> >       for (i =3D 0; i < dest->nr_dests; i++)
> >               total_weight +=3D dest->weight_arr[i];
> >       weights_to_ignore =3D nr_migrate++ % total_weight;
>
> Actually, probabilistic way may be not that complicated.  Maybe we could =
to
> below here.
>
>         return damon_rand(0, total_weight) >=3D weight_to_ignore;
>
> >       total_weight =3D 0;
> >       for (i =3D 0; i < dest->nr_dests; i++) {
> >               total_weight +=3D dest->weight_arr[i];
> >               if (total_weight >=3D weights_to_ignore)
> >                       return dest->node_id_arr[i];
> >       }
> >       WARN_ON_ONCE(1, "I don't know what I did wrong");
> >       return 0;
> > }
>
> But damon_rand() might be more expensive than the roud-robin way, and arg=
uably
> roud-robin way is what usrs who familiar with weighted interleaving may e=
asily
> expect and even prefer?  I have no preferrence here.

I think my comments about the round-robin approach also apply here,
but all things equal, I generally prefer being deterministic over
being probabilistic when possible.

Bijan

[...]
