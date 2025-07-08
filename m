Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDC73208
	for <damon@lists.linux.dev>; Tue,  8 Jul 2025 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983457; cv=none; b=V3jIBeZsNjIU0KgBnn24uu9uMajZGl47SOP/CEe0B+GhkmMeF9O+qdMOUGel3m6zihni/zX6d6BA3m/5B6NucP2nJT4fRbfx/i5PDQsbJlnpG25lb1cmezHTvZhHNXxfV0l7UAQ4hSyYxbB7EeoK3FBDTd4SSlIlllk2mMSBxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983457; c=relaxed/simple;
	bh=tMT8TdqcdoCjqYmHjo60TtEOAFeGLeXifmS6Y6mwk9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3i6kB+koUui4HGm7gMcpgB5c0r4jrSdumAlJQPHES9WNlIbnK9emBkQs9UFacKWV0srNtMnzuv2E07DgbpG3q8y2ZpHexpzek4q/Dxg36Zk/i41nwr45gRjfv5qncA0ijIwlpXcSvzw3OoMGHqe6CruG2B10TwG/1K/2pvGdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DefiQFk6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DefiQFk6"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0d7b32322so678836566b.2
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751983454; x=1752588254; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtgbJ10KrJZ3EWuq4BoZPrGsm8VyyDdoigIM7j7cQhE=;
        b=DefiQFk6pQRHgQTvubVddSyz0cdR6h/Kwd1tq8ckGogcepNWL16VUWQBuXg58mU6QI
         IBsTzASSPrnwfrMU36KkhAx8GKCZl/5peRBJTwvvY6WFTt+E6YbnG6/DNQWt04MdQnsi
         fFqPkVsMPKUp6wQDDScP12cbft7BMw8qlAqhF1ya6envf8P5C3zKx/w1cKb5ZqvvsMcn
         S2CGhUWsyTCKDbHLV+0gj7gCjEQDJGbsdji2+SbImlg2PPXPubadEjd2Q7f1mmGWx/b3
         XP8Dh/5LCd06aM8yX06rdmUh6Xgh/surAuZOgomVfLya4KiQafZvKZFvYSi3RpJVOD42
         WlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983454; x=1752588254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtgbJ10KrJZ3EWuq4BoZPrGsm8VyyDdoigIM7j7cQhE=;
        b=okDNJvSMO56gxIIDA1NSSPdhh0je9TN4jjnkQIsFFAkIa5Dyyw7nQGs45V6wEFk/qL
         OQ9JCGEfcl/PMiushGeeYzJVaRu6KdHBA6S+6vaZ/BtVlNnBzWgM+NnM0G9sGIBuB4tS
         4LuGSPmS9VhfUAkGhj/8TU3Lu3SahKqDh65Pjf+JRg5ZMsuLpSshC7bJYWJhg8o8mFkK
         25Z5rNyh6XIKdsiiO75LgGsA5V6r+0X4uU0049uDh0QbKctmmgg3EOGlNsPt9abv2a6b
         lSyKCWUHSLRh9VE6ZzuFfkHKf/WjEhw8mJbVxnrm5zfS/lXZ1YjigmeNudZxtEXdL3JA
         OUJw==
X-Gm-Message-State: AOJu0Ywt5AovkrlQjEK/AaaNYF+c7cjSdCNxiVtmlc2a+7wM3qj87bI7
	K1hJX5o3qbw9sm7eqrutuHXNNxyvB213255c2Fc+cvb7aOZKIyIVc04hgUq8Mzvug1QZdHsAnNA
	BNMuwfpDSZ2FgPOfl7/A3xRXN7BrnbA3AeXdL
X-Gm-Gg: ASbGncuxysFm+nMYRArJhxWVQmgStFUP+yLEH/7xmuHNNtyEteXUhxvYg3P5kZKlIgL
	M5xJP7ixbNzDGuVGourFAV2rsDiZfd1yDDXOpiR+25o9bvgMXCUethEUS2Qj0kO2CILkNMmO6GO
	qXSkH5y4JYmmUmMNVYy7RtC0aAf3A35YYJ5oOFeSP+PsF8iiGXxbGkls44XV2rWPsIszRUOy2L+
	klFCw==
X-Google-Smtp-Source: AGHT+IHdkbFaU+dLpQhDaOZuqg3wNksTld/NxAT2ZZUYBhmA+TLmM6O2a0YIK2eEPzgmT6XcfgyNk2gbzbE2E3n4w0Y=
X-Received: by 2002:a17:906:f406:b0:ae3:24c:6a21 with SMTP id
 a640c23a62f3a-ae3fe4bee21mr1601178766b.26.1751983454147; Tue, 08 Jul 2025
 07:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250702201337.5780-8-bijan311@gmail.com> <20250702210323.55199-1-sj@kernel.org>
In-Reply-To: <20250702210323.55199-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Tue, 8 Jul 2025 09:04:02 -0500
X-Gm-Features: Ac12FXwtIN_s91ypTwNfJZdzXrjIzaGmHghhjzuzPbLTZXRFfuLAVVSsTsR3A8g
Message-ID: <CAMvvPS6imiPU-v527rCu=Yw6JA1Nc-Ezkc5_uXOSxf8oDjX2Qg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/13] mm/damon/core: Commit damos->target_nid/migrate_dests
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	joshua.hahnjy@gmail.com, bijantabatab@micron.com, venkataravis@micron.com, 
	emirakhur@micron.com, ajayjoshi@micron.com, vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 4:03=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> On Wed,  2 Jul 2025 15:13:30 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> > From: Bijan Tabatabai <bijantabatab@micron.com>
> >
> > When committing new scheme parameters from the sysfs, copy the
> > target_nid and migrate_dests of the source schemes into the destination
> > schemes.
>
> Fixing the missed update of target_nid deserves Fixes: and Cc: stable@ in=
 my
> opinion.  Could you please split and post the part as another patch?  For=
 the
> Fixes, I think 83dc7bbaecae ("mm/damon/sysfs: use damon_commit_ctx()") sh=
ould
> be appripriate.

Hi SJ,

To clarify, would you prefer it to be a seperate patch within the next
version of this patchset? Or would you prefer it to be sent separately
from the next version of the patchset?

Thanks,
Bijan

[...]
