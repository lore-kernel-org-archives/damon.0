Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94D2A49
	for <damon@lists.linux.dev>; Fri, 22 Dec 2023 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhDy+bE9"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4278d8a5d8dso125871cf.0
        for <damon@lists.linux.dev>; Thu, 21 Dec 2023 16:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703205009; x=1703809809; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sN/XrY+o4OaYu2S+U3ZxKmsQLdlYuluu9gEjN0UAhMc=;
        b=WhDy+bE94sB4rwIPNxwYCPlpoHv6scR9OOWX3qKqIFRek72JIQ0iZ80HQZLfeVAvyu
         +cv8SMdcnZ7hcUNJVt6gJtoWX7E783X4P7K1L8TUTbzNOf1H6BnOYB8hxN4jqkhcMRSd
         aFxVJuxsuEf5hjnB53F8wk3SQvqamuXZr6Ndl8H25+kzdRaNCqo+lyHuk06S3wgrnD+7
         oqtdXJ7+OeBaJ5rPuSIw8s81UNT1Jt2X3cbyQBOel+uGjFJJxGFuXJW0IQZ90URQeIT2
         ZmU0jcAEmfQ8Se2bduCGjlPs6iprbt9EG3uLpqbolWnwkc7pZ5//RaRRGwUqojYOXW05
         CAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703205009; x=1703809809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sN/XrY+o4OaYu2S+U3ZxKmsQLdlYuluu9gEjN0UAhMc=;
        b=q8ObCk2wHzZjzISJgVEVbSNhSb9uL5Nu9hY/vwMtozcfS4p7lgs+Q2wWS8EaanBVW9
         jpphI2GA1ZjFXi3Y3Nyb0OcPv0fahZxAqw/U5RuSNOqK+2+TUlPZqus8McSbjSdHIX3D
         OcBnORKua9OivDotd1MqLwcWd//DUTkWRxIMOFgDVS6Lbo6vuV0AaBMWvhoFjiQJ0/v0
         fEx60sNI5LaUDlCjPfE4J+QqpCllMgLt2m6nuEdLyop1+S9rqqhsy6UxBAih4xE9oHh2
         90lBijFnau3vr9cGc/b09mzyXB3kMzstsPNQ55JZfe8NlCkpZNSRe2K85mLGGmSqBmRc
         eLhQ==
X-Gm-Message-State: AOJu0Yzm8GXdp1AVnCBWw/rNcJtUKP8rLwqDrX6d2Z1G3KhgPvkbGNhX
	JYIAw7AKcI8QaLJ9BupArr3faT2KseR7Wzask7+eEIdkFKdz
X-Google-Smtp-Source: AGHT+IEGIBokYFm6kfYazkwZAM6fp7OJRMeithDuk3+nUs89ReyI0Rp0uC/AaWNo6Mkymf6M3nx7zYg+xwN9Jj+trSE=
X-Received: by 2002:a05:622a:1899:b0:423:e912:52c5 with SMTP id
 v25-20020a05622a189900b00423e91252c5mr37268qtc.25.1703205008706; Thu, 21 Dec
 2023 16:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231221-asmgenericvaddr-v1-1-742b170c914e@google.com> <20231221234947.59458-1-sj@kernel.org>
In-Reply-To: <20231221234947.59458-1-sj@kernel.org>
From: Tanzir Hasan <tanzirh@google.com>
Date: Thu, 21 Dec 2023 16:29:57 -0800
Message-ID: <CAE-cH4o85OkMAZ5sH0SiakQi_FqauNYcQ+KhniEd2g5e8kSF1Q@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/vaddr: changed asm-generic/mman-common.h to linux/mman.h
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae,

On Thu, Dec 21, 2023 at 3:49=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Maybe we could add below Fixes: line?  I guess stable@ is intentionally n=
ot
> added and that makes sense, but please let me know if you think different=
ly.
>
> Fixes: 6dea8add4d28 ("mm/damon/vaddr: support DAMON-based Operation Schem=
es")

Yes, that makes sense. Just confirming that I understand, would you like it
to look like this:

Fixes: 6dea8add4d28 ("mm/damon/vaddr: support DAMON-based Operation Schemes=
")
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>

Best,
Tanzir
