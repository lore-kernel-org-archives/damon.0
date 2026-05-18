Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF903C8723
	for <damon@lists.linux.dev>; Mon, 18 May 2026 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779083678; cv=pass; b=NHjndk5vDQ60YLryl+U3h3DyhpH8JvwRJscFRUjcGHQvwpVjrtmhtunDUR94+rxYzuQ9Z0QnIvUwD1PD24okW4STqTc3C9rL8ROXtTrGqhQvIw8CXM2LAfOcafYr21sHI7H4ick4dO468tOWdvcpLYMZyacgNkX4ked4Iv3tTss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779083678; c=relaxed/simple;
	bh=7Pa+dNJYGynoLkAUGjb4J4hrWHiM/xV6A//U2j1wNSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpcdu1pjworFWSUm0pz4m8Coww5s6zt64aT5DPWVMZSSSr0FNntfGNNWiff0TEVQL/BH6/Tt8HO70vqiFSDdkL4PKUAZsF3RXzjBbrud0zTEzEWCl7i8Vfa69OwG9c+0ZlbqBOj7Xn7VMSePBewHv1vdjEGk0hAS6l/Onw4nZSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMLWc3kz; arc=pass smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMLWc3kz"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1329fc4bf77so4638106c88.1
        for <damon@lists.linux.dev>; Sun, 17 May 2026 22:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779083670; cv=none;
        d=google.com; s=arc-20240605;
        b=OcF9VU9asSFTZg1xKwHeFgON3wIB8wlFzhEtVrJd9u/Qu+2cNoK+H1NXoVKFH/fnNq
         WV9zw54H5kH6uOqEOMbuLMdwRIdZmEGyiU47MvsfrhBWryVMPL73jO7ndTQS5EYYRFsi
         NJ9xwGpUnAqKrM+5Ana8MsekNKkOkZuOy8M230+0xpnzcFOgK7IGoBVyXXmZ3KlGDn4Z
         kqGquFM2b+e1BtMqSBMfViuPO5HbBUXbCSoVddt5zVSZVZXrxImimD4RhOQDj4Zgztqs
         5gv97PEQbOgwuW5Jmu1b91ktIhDhVRKKW3+EfnaazqDEGYUcBwuEURlol46w7atlq19d
         7N/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s9Xsm/ouRy8rllw0+gW2As39+lMNLqayO0PK1J5oNAk=;
        fh=g3VMvJQux/HSLIVicncr24svuVPzuNK+KAx5AQfJAks=;
        b=LJo/7l2rjqr4N34l+H4Mg+4jg0iPbGkF4Juw7vrwNl3fxaOOd7fsI/jvRRgGx6HvXc
         GEpt+UPeQoxhi7Y4wTPn5TDjQV0rm2IE3+StxubqiiM5j01ucx0Sua8z/DJW9PKHp5Mk
         Ss4iYGECrEDUKAlGyCNf2wAr891E+74zjLbP3bCd8pfYqltzezkJuGsOP0KZFL0k5UEA
         6uR5KknHMJCqttp0tpVEkOoHi7aPUdbAkGaXjiJZYRrH5CrQM4icFWwWEjMc+mm+26Uh
         aGinKXU7d8nadOKbnrH4TltfCAl+KOTFYqsL8REnvrSm4bVoaUZZLrlsR90gNjWs11nX
         s/Ug==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779083670; x=1779688470; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9Xsm/ouRy8rllw0+gW2As39+lMNLqayO0PK1J5oNAk=;
        b=EMLWc3kz1ko9ST0KOzmDNwRDh0WqrgVAVDBdMk5Up+0g6GaZauDeRyZCHTwbfxG3y6
         qF4sCfKm3Ri5H1/X4PXOhZNx5uo4KoYTZ5b5PzVsKUqDFQquiGJDXo+Iz6hDPqQ7y4WJ
         ppGGXtnuzljghbN/P2Gzssm3eaBqBUkeBPhf6unGSul+93TDBi0egTPPla7XaR7ca3M6
         kHBc/nd9gpOwRdTctHeg8hB0wYKZ6OO+ZkNyNBqcKS/0XKoGFYQNCKThT788wQZURYRY
         RaTUBlnWrOcuCWmnpUtuSVWMlj4PlWAKV5R387KCYc876Do/q4DlRFF+Gz/gVba0p7uk
         ZMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779083670; x=1779688470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s9Xsm/ouRy8rllw0+gW2As39+lMNLqayO0PK1J5oNAk=;
        b=ZCJw0QQGz85zFEApke8wbin/CdYFigKgeuJNuvSe5+R+pU5CU3KTAxobOitvpVBos3
         RVyTIvLakw6aIG84wojfilKNy3H9icrU9YUhFJro04hi4b58/JAIu0xzjwrnMs6m7gAl
         ssl6zFV8Kvgu3Q1J7o4ix7qPbj3BSnxbT/+mZeI4SyvIEvqfsF1lXUT493bGo0GhqSXS
         B9SiV8KCDmwv6AFTFQwup5AVlhbSsRxZ7nBIjb2D+TdBXIvB7hkEzot1mtjWWmb/ZE2D
         4/LHj2jjZFvpEHvZpK8egeZvnmv2snqrjMJcSweFtR8jUWeGQtX04BKE2usfEBpBaR3Q
         s2bQ==
X-Gm-Message-State: AOJu0YxZJhM72mWCls7GOcOxbhXk/NYDleEgLsKCTWbCa9fBmfH4FPQQ
	O3lNzPhaMWeVihWwE2aqCq7N3VHT133mw6Y+hW67BcCeUclvl8v5sadtBVFJRWx/TLk1syNhEdO
	UyI10tQs7KrWd57mj45s6r7FbNIlMNg==
X-Gm-Gg: Acq92OFucdAqZY7NmQxJlE+uqJDONOGAkrjUKNO0m3LdvF+K+uqOHa3aDTMUsdJ/myB
	hWMWzYwfgtLYhWR2Hrom6LPImW4ga8Y0PQ1YhMRxck+crtb/D+iJBBimGp4nMEcxeS1w5vMwuSP
	oR4LBwayM9ArGEG6Zsb8WBghzHczo5E1BQ4urcovGqqY/6nxH1suw3OCcJGibcF35nZGUSfunPq
	lo4j3lRCt/foWl55tOgnSZ4IWkKk8AB5Mevfrtbel8kZ/xFX9FPjeKMbSH6CPoHHWDS9kNBF5wf
	rdykH0o=
X-Received: by 2002:a05:7022:ff42:b0:132:7ab5:6cb6 with SMTP id
 a92af1059eb24-1350451da55mr5923196c88.2.1779083670222; Sun, 17 May 2026
 22:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260516210357.2247-6-ravis.opensrc@gmail.com> <20260517234326.89365-1-sj@kernel.org>
In-Reply-To: <20260517234326.89365-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Sun, 17 May 2026 22:54:18 -0700
X-Gm-Features: AVHnY4JSJ_v1VisgQmkmSmbMTe-WurEHckc4yzgeccnY1Ya-JDuePUsGS8NIYOs
Message-ID: <CALa+Y17XTzjAK5ZyKAKZLN1cAE-+c+2DgqpmuHGWgjUAZMgkFg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] mm/damon/paddr: add time budget to migration page walk
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 4:43=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Sat, 16 May 2026 14:03:57 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > On populated physical address ranges the pageblock skip optimization
> > alone is insufficient =E2=80=94 most pageblocks contain at least one al=
located
> > page, so the walk still iterates millions of PFNs.
>
> So my questions to the fourth patch of this series are also applied here,
> especially about the assumption of systems having most memory free.  I wi=
ll
> hold digging deep here until the high level discussion is completed.
>
Hello SJ,

Stepping back to look at this with fresh eyes, I think this
patch is in the same bucket as patches 1 and 3 (full background
on the patch 3 thread): it came out of the same parallel debug
effort, where I was seeing long walks during the startup
transient on a multi-hundred-GB monitored target -- before
kdamond_split_regions() and damon_apply_min_nr_regions() had
trimmed the initial regions down -- and was unsure whether
those long walks were contributing to the NMI-side
responsiveness issues I was chasing.

Once the actual NMI problem was fixed and the per-region work
in steady state is bounded by DAMON's region splitting (and by
the scheme's quota when one is set), the per-call cost in
damon_pa_migrate() is already small enough that the budget
isn't doing useful work.  cond_resched() after damon_migrate_pages()
covers the preemption case.

If a real workload later shows a per-region walk long
enough to matter, I'll re-evaluate then with concrete numbers.

Thanks,
Ravi

>
> Thanks,
> SJ
>
> [...]
