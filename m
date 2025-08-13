Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963752C0F8F
	for <damon@lists.linux.dev>; Wed, 13 Aug 2025 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755051881; cv=none; b=J8BvrIESFM+noN08lpNEUG/c0pttNLNwq9jBqKUGQq+QndbvlDVRXnPIjlxbUxZecucWjYxSNto5aAH8jqwvoqgRMtVvJVSy9IY0qjrPxTxHNewA051ppzGTQbovXnsBJ5uubTukO/x0y4NH3O0ubuYuheynulKIjxTX0pVNifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755051881; c=relaxed/simple;
	bh=q9YXC2AvQChZOlQpt7r9EgVidHyJwAGpxWS2kxbw42k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqYj2IZ4X25Hj2NlqQK28MJnG3XbclCoKW2aOxx4ndHFj9irkt+bYqlivIf3wV13sSe7vMfTfYWdPz9OPH1EHCHa8yGKuFEDHHKy8/FBDjxPRan/7pU/TxzvPmZdL5Q4j41b1B+tm3EX+9Gdkg46fPMUfjnsQNwO+OzigeTNgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGXQw7Zk; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGXQw7Zk"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-302effd5978so3051638fac.2
        for <damon@lists.linux.dev>; Tue, 12 Aug 2025 19:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755051878; x=1755656678; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VUdHryMevSnkSUQXfqfkpLgibxm8gD25NgpI/OeKaw=;
        b=jGXQw7ZkbfrsBoZ56topLDe1NOzFwRRzSjdkxuYKcaHAsAItQ4lzHLxBr++egCWeXs
         9kQwAhE3t4gBM+2MTrgOklhaWO7SKpF9jnXyU+ELi72yVAy/t5Bkxf/v/hApvmlPffe5
         1b4rAAJEqzWz5lRtBNxC5G1RQ3jaKSjKa+7EIo9p7HEjXIUFC1uzOmt2YR+HUqv//Y0Z
         zmNDrzRLCPu2L86WXgrUcPFNlcWky9AdmGkLKVgEbYlGXfczCZEejD/IA6E5JbWpY3bD
         R2ubUlaQ8qjqyfrwl5wojBsbB/Z5WTq2PdQH6LCIW57pEf6RSbKPKKzx06R9a7k3sOQq
         MeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755051878; x=1755656678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VUdHryMevSnkSUQXfqfkpLgibxm8gD25NgpI/OeKaw=;
        b=asoTlxydi0oU8RDiWn0motPXK6/Lu6FEbLG1nmeK25Cqy1sl7uKeQ5cJyajPo1H+XA
         banUxSxqpFhZpSzuZM7ZKJPveZU+77CjANI+rUFesT7lK7d9RuGGBaxG+SMdOpqHeilE
         CPlUR+HTyCe2mwOsrn2GRwIixQqFSCIEyT6Op/Ftg/8bphi5tTRM1kpG55M34NGBU41U
         hOosrk1QKPNuv0KbeNwuAIcHDPI3ipaAM+GMB06DOKPs5dVgR4Qweo3uJatpdFUYooIP
         tUbE6r/9++7Qwmtd2WE/LP8RDIRA8qUlvb3ZQ5R1PqknvJ/m5MsmJ8Z/m/rf+5mHNFUW
         PcSA==
X-Forwarded-Encrypted: i=1; AJvYcCUE1TInVTFPS+KTOwgqVqe1l7uGIOB8luqbYWwmQ5sJ4YuKgXw9U0Ei4uoE0ogQIZ/1g7hSzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwATt5FW/RGq/EUk5OpHiXOrpx1tWTId1cG3dbwvzlyW60DOl5q
	pYqePkp7rn/hBh2DBYcWRLWho4qupRkqgGV+5on74OMRHqK5AEKBbL1sP31EtySA25U8FOhJypu
	GaHvyG1Roc90mUsbYjuTHNPeY/Ip8DJ0=
X-Gm-Gg: ASbGncuSu8JQyYuJVD0rtAUeikKw+KS4ubZgCZH3SwMMNIf+g5LF2PCJBbf4ynzC/6E
	tYvj+DGb2N6VMg9dUM536h18gI2FKgBCjZY2ls+X7WZfM5z2IBRM5LWXcbsMUbBSuo4O/BvRVi4
	0iDaTW53jK2L+NPkXEUfWp97MypSU90RdYzwJDYpaWg8Fbpes8NryFEVWvlONkuijXtAgw2wzh5
	khq
X-Google-Smtp-Source: AGHT+IGo0XTp+5w595RCq2CoK5dGZMCCP0MpxcQ8TZ4Nkp5UFiu/yt0+lGrUcMdti9MBUGKXosrQajwecyB8b8fBIsc=
X-Received: by 2002:a05:6870:f691:b0:30b:dc26:41c4 with SMTP id
 586e51a60fabf-30cb5d8294dmr771857fac.40.1755051878619; Tue, 12 Aug 2025
 19:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250812140046.660486-1-ekffu200098@gmail.com> <20250812175939.57506-1-sj@kernel.org>
In-Reply-To: <20250812175939.57506-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Wed, 13 Aug 2025 11:24:27 +0900
X-Gm-Features: Ac12FXwjHQssL_GWAi9wQ4Imzh4-_JaTL63Mge2i3rUa0DLMiUFRVU7qx9boE0k
Message-ID: <CABFDxMF=-Fb56zSnGVvqXRrDXh-3vFzQmhuLNDYEzFv4z-bsuQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/damon: fix selftests by installing drgn related script
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae

On Wed, Aug 13, 2025 at 2:59=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Tue, 12 Aug 2025 23:00:46 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > drgn_dump_damon_status is not installed while kselftest setup.
> > It can breaks other tests which depend on drgn_dump_damon_status.
> > Install drgn_dump_damon_status files to fix broken test.
>
> This patch conflicts with the similar one from Alexandre Ghiti.  Could yo=
u
> please rebase yours on top of Alexandre's one (and mention the dependency=
 on
> the comment section under '---' line), unless Andrew resolves the conflic=
t on
> his own?

Oh, I didn't know that I can use the baseline with an unmerged patch.
As your solution, I can avoid conflict (This time Andrew already did
it) Thanks for letting me know. I'll keep that in my mind as well.

> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
> > ---
> > While setup kselftest executable environment and test this patch [1],
> > I found similiar issue. Honestly, I don't know exact solution for this
> > situation. So I just make a new patch. Sorry if it is wrong direction,
> > then please let me know how to do next.
> >
> > [1] https://lore.kernel.org/damon/20250812-alex-fixes_manual-v1-1-c4e99=
b1f80e4@rivosinc.com/
>
> For patches that you are not really confident about and hence not insisti=
ng to
> merge as-is, but wanna ask other's opinions first, you can ask questions =
via
> plain text mails, or post patches with RFC tag on the subject.

My meaning of "don't know exact solution" was about conflict patch
(Now I read again, I think other people might be confused. That's you,
sob) I will use the method mentioned above from now on. Anyway, thanks
for reminding me about RFC.

> I think this is the right patch, though.
>
> You could refer to the TEST_FILES part of documentation[1] and "Install
> selftests" section on the document for more details.

Thank you for this comment too, and for your always kindness.

> [1] https://origin.kernel.org/doc/html/latest/dev-tools/kselftest.html#co=
ntributing-new-tests-details
>
>
> Thanks,
> SJ
>
> [...]

Best Regards.
Sang-Heon Jeon
