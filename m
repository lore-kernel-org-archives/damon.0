Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD482DBF4C
	for <damon@lists.linux.dev>; Tue, 17 Jun 2025 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190094; cv=none; b=t1X7B1Hxx5w7jwAUjfd8O76LFZQ7RKmPtXww0UlyDggwMJaphu4H5aba/B+++cHtVUD61QWO3ixae2wkNQ4lwpJTysyRu5h5pPJFPcolK6WrSvsv+VGFFYOO1IJzv3jrryp6b1P3yfT+MqONb3hQtZ4CVEkJCfpMAMoLdvOTiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190094; c=relaxed/simple;
	bh=Q6LN0h5d3N6f3RZyDg9qhMGAr0lG/K582gkDWgFgagM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmIMJzpygXepKtl4yjhdfSbq3cWwZk0xJBgirfIO8fKWirKhtDy1Atd/byqxfUIbVr6DiuSw4Qyu9JsSnf4LIlX+5tS9jn+R6uq/m8INkJgkRNmGcqZw8daYJJbkOlSbMCSdpAVMIc/myqj4YY4zH9HD3nVlLpjaUwKNdGFEH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMhORGf7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMhORGf7"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-adf34d5e698so4066166b.1
        for <damon@lists.linux.dev>; Tue, 17 Jun 2025 12:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750190091; x=1750794891; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8X5Ja/e/pqiuPJdST6phpTFMTSJg44mlfySHdQTIHE=;
        b=BMhORGf7YPb8IWGCW2DDhLl6Eylp9rIaW5KtxZXfQaZdehkqTVoXlOueQlHJwzhyyV
         h5/Izea/t1Qq150cU+WE4CO4fFAKzW+KQi+0SzHejmaxCqlGVBAQ+Bj5gM1fOluTkVYQ
         RcXL+R3+t4iTk1YiSVBwl9szgvEbJ6BY869mRQ0O25ybk9mPZFwERgbj/dWWmLq+9kXP
         7dU9oIEUK9hsXmdj0Edbpf2aowJcROpgLEImLoMdMoIvAZgyLwvbrenOs8iEgwyK7EQJ
         lzcGaQ0i/h1SRBMY9RfnSOZKnRSXLPCwNDlRR9UoWk5y9pJ4P8HmNEF/cyFL3EEXnsDu
         QTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750190091; x=1750794891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8X5Ja/e/pqiuPJdST6phpTFMTSJg44mlfySHdQTIHE=;
        b=W1/gE03rzklBrehbh/75xek8MjMtzKIiS5shehDj6opSYoal9dWSBj4DjsuXDCPEj5
         eXf/6QuQedB4Qk4dfYNZiF114UWdj426M66i71AbCRSRN44oXc9nkRn9LJFtqnKHnUP5
         au+9Qy1Qt+t8dbN5/55ae56GPogZXCtNVIej6sgCUN5/sVb/EWMSoG/ZWsTDij5QxCUu
         6xPhPrcGIdizRbWC1ITUi07B2If2vA7bE2foquPCXJsCKnQB70dn47Gy9t/Hb5V8C593
         1NxYXPJWbPwh+CeYtpHxaDMYeZ2K+uBIn4iGn/suF0Ka93aTCSIIf9AQnNNRmcNbXU2v
         L1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVX0JKKapBtWE3N/+xslWPj7C4pIAqcMqQlyFDb4N30QxL7uGRvBalynvkfpgzyZVwmL+493Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzepxLN0t8Y8mbhAFL/5wuh9CGvw0UM8wLSUVycZoO/40b0EuKd
	i/AGRl8Zpz9v2qwSRNIACiYHigj3GZoJ1NwHoA5ZBt4JPVpYVNofcLii4/jRbdz7eV5e7/pgiHZ
	BKpkgtCraLDRCdcCnRE4S66uB7UO9ltY=
X-Gm-Gg: ASbGncu44wEvQZRyLOzT0yOq2gOy4tnZAc23qNMaGSnwVrTHk4Z3UFftHyljvtTHzsu
	0/6MuId1CAFXMI7m6MjabiDTJvm6wU0LnkuRmBfISQapYJWnzVL920VnueObHX9YSEqR0obAzQn
	Tcqmo4EIDwy0HV7mG4dWOGjS6Vfmn3xGr4L7KdvCb2Pw/zDvfE4sbO5OEv5fwCfIb1O6D+erboy
	8rxng==
X-Google-Smtp-Source: AGHT+IE8e79lXnYS2MEWhgyzWvzB+JeRzaYD17D8Gyd7qKRDrq3kqUlcKtRYC/AYY3nnyTbqfzHmUGafLodcxJ+tGmA=
X-Received: by 2002:a17:907:97ca:b0:add:f68c:5200 with SMTP id
 a640c23a62f3a-adf9bfdc8fcmr1493396266b.6.1750190090999; Tue, 17 Jun 2025
 12:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAMvvPS4aiyA7nXTN=QkMz4ikvf77ZaZ05ys-4N09AFLrgeS_Pw@mail.gmail.com>
 <20250617185834.58000-1-sj@kernel.org>
In-Reply-To: <20250617185834.58000-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Tue, 17 Jun 2025 14:54:39 -0500
X-Gm-Features: AX0GCFsNgriV0sYFpbxGGJwvblVxYmQtu1tLr-OLt3N9F1vqCPvhgnz7IQ30TGI
Message-ID: <CAMvvPS7yQPoXxAecSi6B74a1Bgm1H06i+MqNDgdsZODEZSYFuw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] mm/mempolicy: Expose policy_nodemask() in include/linux/mempolicy.h
To: SeongJae Park <sj@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	bijantabatab@micron.com, venkataravis@micron.com, emirakhur@micron.com, 
	ajayjoshi@micron.com, vtavarespetr@micron.com, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 1:58=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Mon, 16 Jun 2025 17:16:16 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> > Hi Gregory,
> >
> > On Mon, Jun 16, 2025 at 12:43=E2=80=AFPM Gregory Price <gourry@gourry.n=
et> wrote:
> > >
> > > On Mon, Jun 16, 2025 at 09:16:55AM -0500, Bijan Tabatabai wrote:
> [...]
> > > I will just say that mempolicy is *extremely* current-task centric - =
and
> > > very much allocation-time centric (i.e. the internal workings don't
> > > really want to consider migration all that much).  You'll probably fi=
nd
> > > that this project requires rethinking mempolicy's external interfaces=
 in
> > > general (which is sorely needed anyway).
> > >
> > > I think this path to modifying mempolicy to support DAMON is a bit
> > > ambitious for where mempolicy is at the moment. You may be better off
> > > duplicating the interleave-weight logic and making some helper functi=
ons
> > > to get the weight data, and then coming back around to generalize it
> > > later.
>
> Thank you for the nice clarification and opinion, Gregory.
>
> >
> > This may be true, but I think I will be able to avoid a lot of this
> > nastiness with what I need. I am going to try with the mempolicy
> > approach for the next revision, but if I get too much resistance, I
> > will probably switch to this approach.
>
> I have no strong opinion about use of mempolicy for now, as long as mempo=
licy
> folks are fine.
>
> Nonetheless, I just wanted to mention Gregory's suggestion also sounds fa=
irly
> good to me.  It would avoid unnecessary coupling of the concepts of
> allocation-time interleaving and after-allocation migration.  Also it fee=
ls
> even more aligned with a potential future extension of this project that =
we
> discussed[1]: letting users set multiple target nodes for
> DAMOS_MIGRATE_{HOT,COLD} with arbitrary weights.
>
> [1] https://lore.kernel.org/20250613171237.44776-1-sj@kernel.org

Given this discussion, as well as Joshua's comments earlier [1], it
sounds like while people aren't exactly opposed to using mempolicy for
this, the building consensus is that it would be best not to. I will
move the interleave logic to DAMON for the next revision. However, I
still think it makes sense to use the global weights (probably via
get_il_weight) for now to avoid allocating pages a certain way and
then migrating them soon after.

I'll try to send the next version of the patch set by the end of the week.

Thanks everyone for their feedback,
Bijan

[1] https://lore.kernel.org/linux-mm/20250613152517.225529-1-joshua.hahnjy@=
gmail.com/
[...]
