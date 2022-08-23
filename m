Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8CED4
	for <damon@lists.linux.dev>; Tue, 23 Aug 2022 11:39:49 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id 20so12552003plo.10
        for <damon@lists.linux.dev>; Tue, 23 Aug 2022 04:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=HRfba2ZkYZCM1D9aUkoUNXDUBf9660MhvdLdrBTo7Ss=;
        b=AAeqEBL9MB3YAtJpl/qAbJ1vzCqD98FgvuD+7Rk5AdKB6lBVp0jXbIAWVrSSeX6aH4
         05H4uY151vzAPipETs6T4Zgrnj/Fg3qGU3Q3YV5rNAI3ceF3Dz/c9mvDLp8pbF5e4ai4
         hR3q8tyxuScXpx6aszPHzBEW/9S8vpz1L8Y9fu0LHX/OCCe171ZummXza3MSW9B51AxO
         OoRaekDYjH34NJOTlQMWLUoz8V5NFLUR+XSuQoTmOPHXgLpXzqRuALKXd0KrWbtKKlAg
         Beda/HDxoluaLCTp+VQ00kJpd8UXeJFteyXXk8bf67+pJc3kcG5BJs/LoacihQQh98wZ
         2seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=HRfba2ZkYZCM1D9aUkoUNXDUBf9660MhvdLdrBTo7Ss=;
        b=iLGqfk1x6wQQTdd9mlZJW9nP9A3dmFdZ/fhFhfsIBEWUfQL6u67w1GoXRuch/N5UDH
         8koaD0Wi815hHAUfI2V3/BGc+r6gMwuqXWv/lZhdqgroz1uq9o5gc54m9t+qq4rbkV71
         GSjZdyTn1Mgl7q3Ast3c/s6rOHqggbqwC6LA6WIUQ/RKMcZUtskzWnnA73S7EnQ6sQzO
         zWvfKSmmjvL6x4GLOj3bclUyPFeuYjiu456bB0DbPP35ShO1EdfPBiG+uJhnacxleg7j
         DRkNRG5CLl//k4nekuToStK267TUQ6KvLCLqGrq7XBKGg0wHpFARenwDyFpPUOrJJ+J/
         qQSw==
X-Gm-Message-State: ACgBeo3buVstqCV095U5mVKBITx2AC3o5dJxaK9+JHLlbzpp8DQ1PrPs
	oksLwrqfUKV7aSIOQnYlB+BqgjgLC3Zwv5CzwMs=
X-Google-Smtp-Source: AA6agR7Xi80ZOmP/zesxSF5UOCSBzj/yY4cxIphiOeR38Ai5oiZ64OVCe9jwC9ZpSafIck+lhkfVn1cdQABanRd+91c=
X-Received: by 2002:a17:90b:3d7:b0:1fa:e708:ef43 with SMTP id
 go23-20020a17090b03d700b001fae708ef43mr2910997pjb.239.1661254788863; Tue, 23
 Aug 2022 04:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220822165646.87524-1-sj@kernel.org> <20220822170500.87712-1-sj@kernel.org>
In-Reply-To: <20220822170500.87712-1-sj@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 23 Aug 2022 19:39:36 +0800
Message-ID: <CAMgjq7D989Ki-zHN5=yY+MYj2tUqizmg++PSK=5J6epr4isF6w@mail.gmail.com>
Subject: Re: [PATCH] Docs/admin-guide/mm/damon/usage: fix the example code snip
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

SeongJae Park <sj@kernel.org> =E4=BA=8E2022=E5=B9=B48=E6=9C=8823=E6=97=A5=
=E5=91=A8=E4=BA=8C 01:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 22 Aug 2022 16:56:46 +0000 SeongJae Park <sj@kernel.org> wrote:
>
> > Hi Kairui,
> >
> >
> > On Mon, 22 Aug 2022 18:56:17 +0800 Kairui Song <ryncsn@gmail.com> wrote=
:
> >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > The workflow example code is not working since it got the file names
> > > wrong. So fix this.
> >
> > Nice finding, thank you for this patch!
> >
> > >
>
> Oh, I forgot saying that it would be good to have Fixes: here, like below=
:
>
> Fixes: b18402726bd1 ("Docs/admin-guide/mm/damon/usage: document DAMON sys=
fs interface")

Thanks for the review, Let me send a V2 adding the "Fixes:" tag and
your review by.
