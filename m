Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DAD39768C
	for <damon@lists.linux.dev>; Wed, 16 Sep 2026 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522803; cv=pass; b=ccFcDlSo1QuNGwX9Q8cccUxFHbHDDiwCWQDhigt1yBdzCQ77zxmXujtE1eEpV5ttvtuTQgByKzAUlPS9rX+w/0Vz1iAYIHLJaMpwX87tBRwD6HDqbaUo38qvQeVESi7pw8X4IOS0ufHhwG8cI8GdM737lHx/1PR/hRD/M6muWXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522803; c=relaxed/simple;
	bh=F7/Be39iQ67QXJSJm73iOaskwF1HV5SnLrr7SsaSjB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaRZ335/rsiwpebA/ejq4kfmlXyRVpc1hRCUGV9bmkFivYWyHUw3yrAEJkmwkhtG2NW2+9wxUeROb5FQ04coD4rT8Q+amXnr4JGPlkrunnt3NINjENd4LDRvFXiDZQtrmHAJafrT6QlDgh8xElOSxrIqLgM0LPQiVEa25Zb93LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cP0f8r6n; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cP0f8r6n"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so2745055e9.1
        for <damon@lists.linux.dev>; Tue, 15 Sep 2026 18:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789522793; cv=none;
        d=google.com; s=arc-20260327;
        b=ihzu+KiW/emxxEXaGuQ/V7FJXvh9mzBjPqMh2+b6OOnbWLg7m5n7b/HRLFIUZ2gzYS
         I+lUF5Wdj5WufGKLRmMQpBxmI+KCAkyZLMInBkkbpVUnM+2is4ZbvxjL9iWLavJBOhWZ
         fEBfutJr5mAKCr1r/O0pTH9kfNuHabEUG7as6RiaI6NT2wBV6vj02uOcQruTwxwGjdj5
         gffeIV/fm8V4MHT8ykxROUa8OdwokbEp+ks44s/XV8D2ttpbA8LzcvdWPszA6RheYg/7
         sDNOhUvMwyHtFuSk6cBf4blKdiAxh1x+UnyMrZWWyLBd6fgq3F/zeDGHFOsxwVBQCxq8
         kqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F7/Be39iQ67QXJSJm73iOaskwF1HV5SnLrr7SsaSjB4=;
        fh=6VBbschQ2qJXYfy5oe4A7WLZTIhcKW0ftjsmJOfL4mQ=;
        b=G8HmXjLb7gxvH9BuoTMxvLmpSy/U1TbxxCcoSTwLsNEpmVi2b98g8rL3wJe1/ZrosA
         16eX0C/rH52J/GBpk5u8gjxgbHgWfTYqGvxUfHBgqgtMUGi6vIqILNzdpu1Auvry/EQw
         MP/TL4oMYjW8OA1OhIZPw8ye2MMwYqTaRdNzPGnhYAlh8rt+Ef/8McV04fHWnuFi1L56
         utAl+lN5G6NenGyEXcBjnlm3+1fWNpbnPW7J7T0h5YeatpamuzdMnj3DPljxcDLxGTOt
         ZVu9cTmrjwJzHwbFMJ8B7D7hE9fjm2m6ZTFmfMhSCyoyQ/9R9dI81Mq31vKAsEkvmf3D
         TPEQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789522793; x=1790127593; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F7/Be39iQ67QXJSJm73iOaskwF1HV5SnLrr7SsaSjB4=;
        b=cP0f8r6n1+rqCk85qlzOT/woySXxLoMCPgAXpFniAtkU7/xG9N8sMDdsDbFmA3Idk5
         8qFRmObJPG5z4whlbnPKVs5PADWdKmPzfoxFJJlNYv9bCpnXld8xe3g/2ExPMAm7+niY
         uuSiDI6dO+t4Idyz0az6ks3g/9kHrufCK/lpZ8cx4cRBahK0xaCsF+rhcZRf98KyXxN+
         p8tI0yX1DvN6Mntkqqf2+wON0xU9ZIde8wbmkWp8Y82+nG4aedfZi2+ec82AciYUyIwh
         tkHfS+l0axKNksArvtRn/TDHyKauN4vMKBv4jsibw+cgkFeF0BUfxhwyJvQq/KXxho/Z
         TOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789522793; x=1790127593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7/Be39iQ67QXJSJm73iOaskwF1HV5SnLrr7SsaSjB4=;
        b=UluUWh6pQwAbg/Nxzai0bPi3H5XV4vocfkE/NZoYUdUNlEh+DPNOmRlI7LjfyV/zSU
         a2Gv1yka2eUPI1W/fOb/H5shKtLDlLM10r3ZC5fESIaxTF31CKY/4vZ7Ixq1LSp04ErS
         KoHkvYg7Tu5DPAekuCypGPlx6C2IUJf0IB/n6WLede2y2JO33BkpjUEcyl5rC0l4bknL
         UTL1c4Nap5zJgAeCBgUUCt4lMKyppyGDRrcDn5vl+wX3PAaQW2LNYbU9q5EiGX+iJxzG
         2lmTdNdMto66NaNqGTrTbwC9fmY1U7ag9ddqerWK6sOOLQK7cM+YdcfpHKoaQgG7Egzr
         yNGA==
X-Forwarded-Encrypted: i=1; AKwUvByX0ifHnY15EMjNBru2xf2OC//Dgac1WFn3VJ1/eS21ghFGFDxtj/Z1zkpnt8LTCiHvex8uZQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lNfZ5OIgOvJy+E4H7xjZanZlZDfcDKUY/6rOfQJ6sGQ9Dksd5r
	bE6OdSxm1pX9naXkeo9Ueq4yoCUi1yvLsQhrBuuFY+r4LYTBurz988bmnBYZft/jZFI7pUCHLAx
	dgA9Upb1kkj8S64eG7GPTJUe2bqrEG6o=
X-Gm-Gg: AYBFou1IhQ2xQEhMvjkzdZXeg35wwe9cV2aEnSsufVgnUbaWjzg5wW0N29SfBgvwPWd
	3zk6yw+M2zeQ+KH5wfXh3u8Hx2kULq6tInWWwRCsOg2vYhVTPi9+VBrNpCjQ1/ddUQGFp7dPmeQ
	NvGExbbyjxqxCinBmm7+2bfyEE5iB2gi+8LOSKnrrCV7tyDM5+Cj1fSfbg7kT2d/ARMVmj20Fwy
	iCs6zyPEsdSgQa8HTFHagz/eWi7nQYt1H5uZWBJLVkF/flUTqbFmGY6SwNtfTMFCdRKyKuKe3GV
	J05GWQL4T3ORGKlqNvPOHnzfIF89OO+U66YYhl3/yd0U1BSu+hBpD1PoAK1KseHeMV6/lZvpU74
	hOEdGs1WsbFqD
X-Received: by 2002:a05:600c:3487:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49eb7326671mr12886295e9.10.1789522792473; Tue, 15 Sep 2026
 18:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260915033050.1579457-1-kunwu.chan@gmail.com> <20260915141428.90098-1-sj@kernel.org>
In-Reply-To: <20260915141428.90098-1-sj@kernel.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 16 Sep 2026 09:39:41 +0800
X-Gm-Features: AcwNN1WkItfrjGuvh4D30_0jXdjk_3N_mQEQU9h1o2CriinlbmIT02nd1bs-e_4
Message-ID: <CAN_Opa8kqT3veKMw2Efir1p4mKH3oQuD5OqyBigjiBMvw7pjnQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/8] mm/damon/core: return an error from damos_commit_filter_arg()
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lianux.mm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 10:14=E2=80=AFPM SJ Park <sj@kernel.org> wrote:
>
> Hi Kunwu,
>
> On Tue, 15 Sep 2026 11:30:49 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrot=
e:
>
> > On Sun, 13 Sep 2026 10:17:00 -0700 SJ Park <sj@kernel.org> wrote:
> [...]
> > Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> Thank you!
>
> >
> > I'll take another look at the remaining patches.
>
> A new version of this series is available at
> https://lore.kernel.org/all/20260914142327.92510-1-sj@kernel.org/
>
> It has no real difference to this version, but it would be better to revi=
ew on
> the latest version in my humble opinion.

Thanks, SJ. I'll review the latest version.

Thanks,
Kunwu

>
>
> Thanks,
> SJ
>
> [...]
