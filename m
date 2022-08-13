Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC707E
	for <damon@lists.linux.dev>; Sat, 13 Aug 2022 14:33:31 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id z2so4467201edc.1
        for <damon@lists.linux.dev>; Sat, 13 Aug 2022 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=za38B/WdiKJtfUmwIszIpVR/GOOwQNFkxMaiPO2BEsE=;
        b=SRS5VX4DgFVtp+A0rN1JhpRO941soVLdg90ecmG+XQ0O0Pk71FW0Pnz8yHfIzncjfm
         w9vBr4X/fCJunIlmhImV1SN4JHWF76kgYCXcIiI1d3N9VGZpSUARDumzbJr1NyXQ/y2c
         xl4sdAP3i5O12b6Ip2R/jya5p6xu5xMddi8Pxlw7eq/IEQ6HD+3yv8y+lu+TMSGolZmy
         T1my/uu5mISAvK1SJnfKyo4UErW6OWGA38vCibiC0oR7zQJqP/8REV5No7LCotDsP6w/
         5aNp4dTcnSdt2zTERyY/We+lAkR6JSCN2UFnjtWSoP/0ZZaPfZmJJe4TyS7j9xKwOFfG
         vjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=za38B/WdiKJtfUmwIszIpVR/GOOwQNFkxMaiPO2BEsE=;
        b=pr1IEmOWE3X9TMbME+QHzuUW5N8EK+RJdwoCLF5jarGEmpYqjCzg2CKJRS2TBey/f3
         qsjsBvVTW1VkmR1DVLimLQk4ViQ5Bo12vYE1gxO0jFEdo/f3GXFawQZjd+SbLpjrsEcn
         PxBySVTg9vpWIuqu7mVMYJLj3MlqzIDCtilfo/hQ6GErtPA2YGVSjhDez8d+C5xfMQjz
         I1tkOmOqqJpKFS8fNljP3qeZ9D7Jjnv5c1quFi/Ytdl6VQb88CzG6Bb/fJOV2PAecfiR
         LMTv9l6Wp7tr0KgtsCr9desM1DoqGv4ce/rbm3QIBl5JrUNhl0zITnOqL1+cP5eWO2SD
         6uqQ==
X-Gm-Message-State: ACgBeo14RUYt3mig2pgqdowY6pZZ0aOG4RFyh81hJQiPfZxXzZhXvSA0
	2Cccsd0wowQP+aMgao/MrLR9CeAB+SQ37MwaNQ==
X-Google-Smtp-Source: AA6agR7/0O5iWzCnwrOz4bhtktALLvhmcNbjjxALsSbZe0aAZ1sGeKW6/lTWKsM2lcpAxJVv05nSRWz+4CDpDtjIXfY=
X-Received: by 2002:a05:6402:240a:b0:437:d2b6:3dde with SMTP id
 t10-20020a056402240a00b00437d2b63ddemr7723134eda.62.1660401209608; Sat, 13
 Aug 2022 07:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1660290073-26347-1-git-send-email-kaixuxia@tencent.com> <20220812154841.116570-1-sj@kernel.org>
In-Reply-To: <20220812154841.116570-1-sj@kernel.org>
From: Kaixu Xia <xiakaixu1987@gmail.com>
Date: Sat, 13 Aug 2022 22:33:18 +0800
Message-ID: <CAGjdHukHNavhfTB+uff_9F3+VPhzXzP9bPnUV1Mcz4dX7rF87w@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core: simplify the parameter passing for region
 split operation
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	LKML <linux-kernel@vger.kernel.org>, Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 12, 2022 at 11:48 PM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Kaixu,
>
> On Fri, 12 Aug 2022 15:41:13 +0800 xiakaixu1987@gmail.com wrote:
>
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > The parameter 'struct damon_target *t' is unnecessary in damon region
> > split operation, so we can remove it.
>
> Good finding.  But, 't' is used while 'ctx' is unused in
> 'damon_split_region_at()' and 'damon_split_regions_of'.  Below code change is
> also removing 'ctx', not 't'.  Could you please update the commit message for
> that?
>
> Also, please fix the kernel test robot reported issues together:
> https://lore.kernel.org/damon/202208121823.8YTRPB1J-lkp@intel.com/
>
>
Thanks. Will fix them in the next version.

> Thanks,
> SJ
>
> [...]
