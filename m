Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9F1CAA7D
	for <damon@lists.linux.dev>; Wed, 13 Aug 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755052211; cv=none; b=o+ZqNCc5CdL8vpJ0m9/7yGmiMtEvXgf9h5iytPjgyRHLv/F6hjUEdei0OrnqxB6Tpvuwp1nn0nSdFBmZZkFxGNhQKZQWhbpb4XRTTKhW7fFdrUtcfYqYNQl6Ngn3KqcKo5Zip80E3lCxw3OlZQm8HvceUFR0vSsVoPA7HxlSStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755052211; c=relaxed/simple;
	bh=Q8HBZTAmyt6Y5zdgIwh3VzQlS0aR5WfkfDTX4abWqJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeV8MaDqRkg6Q5S6RPC268w/TdNnEc2OuIzb08JDlr3cMmvl8zFhjQhDechzGDRZ++U+oUCNK5Ov+cZtiWSpdBRhXw7YYvp+Uz+LyBX1G8W/2Oenb5par/znybSsZUAWiJnXlrejWhSkLNgXD/4cNb88vNMvCH/kNq3Gc2hTdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0NMKbii; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0NMKbii"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4358a73e7efso281336b6e.1
        for <damon@lists.linux.dev>; Tue, 12 Aug 2025 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755052207; x=1755657007; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iJ3fy26qNpnuJDocl05IX/Jr0WaaCnqMDH+qK1cFXY=;
        b=O0NMKbii0IjplB3zVUBfy8RNKAoaiiWNZB9vbFNqjyTkoBO7Zcbjv49naqz2sxQu/Q
         rDvSikILZpJG8bWUrq3Pxv2akOdZyqMmZediVbjuSi43TWU949RLoJ/csdCRBRUfbM3q
         0K+qDr1owlxkLFL7ex2yf2pYRBrvrQVVbOfyZrDSVx9vrEeG5Mjp9aBRo0wz76FVULzK
         WStYEjoc0ONjsZPCvML23EYvENMmR9eiBWgDFzMnVL70Bean087Kmel/glBSuWmKqg+F
         oJRXu8eaIzCTzLD3o5TW89PALgVBcoJleyilN7ws4by4iTGa9+OarSCMgaLVeIbafV8G
         0qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755052207; x=1755657007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iJ3fy26qNpnuJDocl05IX/Jr0WaaCnqMDH+qK1cFXY=;
        b=SudCP5F15Y+P1X77guUm+UD4vQQzZbRa7QmiqSk/wbhu4zmWqKRFgrvN3I8ItvjIDY
         uh8SHhP+uLEpf5eK/1c6JzGdS74DyX0J0+QzhelC7YIODa+pYHsu0/6DINUgR48aZdcQ
         vZOXQQJDlEAa2iXZL6DRODP7GhLMpqmHDJzIEJ+l9tJwzfQOVGD7i4ho1d7ggt37VFVG
         KhweV7DRNSAaaJOEMGqGTtudltLxs5wrFBu6n1VZyveDrO5FvzYGoqbc6PCzB9hAmvNR
         t8Ba95h0ZG8oJCb5O7idErJ/UrpnB6WF328E3o3TYpKu/EQ3wMUPyeKFG3Irc8xdOWUI
         ejQg==
X-Forwarded-Encrypted: i=1; AJvYcCVsW43D7ovroPa1IEOpjRLyx2HAvTei9y00WonLVLz1xxgy+FlH1p8GpR/Y7ZCyVVtZKNytaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5LwU4w5no3lXvWJf0TCchPwJkntBVXQPur4gMS/ri94SayA0j
	pcXwicc5jye6rnkLv5pYCgdDYnS3rEb5vbXZbdEu8guvOuuxr4W/m9ZNuKQcYnWt4fF+ioYO8/g
	4to7MGfhey72R5Avc7ZRwbbseFMheBEQ=
X-Gm-Gg: ASbGncvZTXAHmBkBjGXoiCiqygw6k2P6JqZCZiWDoF4EkR52VuumA5WFI5fIg/EobQ1
	L2jCETwcPGZTY8ZFlF3R1kqFtYUlmArWAgwji2yAKbFSZC/ig3IjY0v3pcoldPeQx/3KbbyfC3/
	BgnPmQh2mpM3+q9dYQ3OzY4Qd11FMjBhk9el7f/YiZ2aDyk3Ba2ZmXza9B8QmNbuBlCdo2icQdB
	vGy
X-Google-Smtp-Source: AGHT+IFu8/eVv3h25CS+PDVey9SJ862VPhA2HFsoEUFWCqaq9DWpbBe2Iai0s6TSEjG8fKnzDi1yuAperEC0PQIv3po=
X-Received: by 2002:a05:6808:1687:b0:434:b72:de0b with SMTP id
 5614622812f47-435d6293de1mr474390b6e.8.1755052207201; Tue, 12 Aug 2025
 19:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250812140046.660486-1-ekffu200098@gmail.com>
 <20250812175939.57506-1-sj@kernel.org> <20250812151743.570bde54f31007cf986a2f52@linux-foundation.org>
In-Reply-To: <20250812151743.570bde54f31007cf986a2f52@linux-foundation.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Wed, 13 Aug 2025 11:29:56 +0900
X-Gm-Features: Ac12FXyjyCmdy5Tzo6RVFntUUEEiKnyDu9n0yq3bW9uFdCcLkf7VKBGRRSLMU9c
Message-ID: <CABFDxMHpXJS30nD8-Jp6u00yLqZ2pfgzM-rUqKtoMF1spM0GaQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/damon: fix selftests by installing drgn related script
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>, honggyu.kim@sk.com, damon@lists.linux.dev, 
	linux-mm@kvack.org, Alexandre Ghiti <alexghiti@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andrew

On Wed, Aug 13, 2025 at 7:17=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 12 Aug 2025 10:59:39 -0700 SeongJae Park <sj@kernel.org> wrote:
>
> > On Tue, 12 Aug 2025 23:00:46 +0900 Sang-Heon Jeon <ekffu200098@gmail.co=
m> wrote:
> >
> > > drgn_dump_damon_status is not installed while kselftest setup.
> > > It can breaks other tests which depend on drgn_dump_damon_status.
> > > Install drgn_dump_damon_status files to fix broken test.
> >
> > This patch conflicts with the similar one from Alexandre Ghiti.  Could =
you
> > please rebase yours on top of Alexandre's one (and mention the dependen=
cy on
> > the comment section under '---' line), unless Andrew resolves the confl=
ict on
> > his own?
> >
> > >
> > > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > > Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> >
> > Reviewed-by: SeongJae Park <sj@kernel.org>
>
> I'll add
> Fixes: f3e8e1e51362 ("selftests/damon: add drgn script for extracting dam=
on status")

Thank you for your help. I'll do better next time :)

Best Regards.
Sang-Heon Jeon
