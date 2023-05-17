Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6482D53A0
	for <damon@lists.linux.dev>; Wed, 17 May 2023 06:23:21 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f41dceb93bso2119245e9.1
        for <damon@lists.linux.dev>; Tue, 16 May 2023 23:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684304599; x=1686896599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NS9MMOeGbk46KEukFDZfhL0rwBxUJBfRVrmkoFj2ZF4=;
        b=mYqdXP8J9kEaCTfDD7GUZxQFJSqPwzz7ecfonARTNk9LHk+2ba7eNClMd/ujaR/Tmd
         uN48x9UpqckKUkZNW0R6kAwhFM641KB2yHZa6D1y9pEkB9SA26CNDs7GTe3Ji6xLSGk9
         eVAyjTB9gFYh3chvTv5RMRtZmMg3jdooU5jvMfRX37U7ExSNgwCranU/+J7UFmB2USj6
         9yzjSKj/W3bp35pX6hrizwjftEpvnt4HhUc7aEy9k0YCHgopRqhgeQxEIzn/bZnjdXxK
         yGHSyXGT2oAOwUgNnGwdPusK5EYBDPIfXSfA7NL3wjveDEP1+AgLOPbjDk7KdETbJ7ZH
         kfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304599; x=1686896599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS9MMOeGbk46KEukFDZfhL0rwBxUJBfRVrmkoFj2ZF4=;
        b=MZKIOCjetVVGWxcZUIe/R7bZnuypPw7RXcxyutgtFlyq5OaO7cFL+f3ECezZEJWDIG
         WKgSOYgTfCVQ21QNjZGu5kkspGmBEzOhiLh12vhWgAK8z8CtL0+uxk/amoekF8XVe7/E
         eqeBoLV0T/40ENECJQp4nNeBt43mnG1WbHX55j5kCncCp6gLXwDINWft6RFxorcq53p8
         aqM3ZV13ChnHxhZjpvifV+COmzQsg+6zL6P0FpaXfyZzESSHTFW0p78R86bRJvh1xrhM
         eGfSR2293vXLx7tPuWF7bjsYcHXEdlgBtQ2S7acZU/C4AlExcbyZOroirEeInum379bK
         eeZg==
X-Gm-Message-State: AC+VfDxW/7WEi//AOTipv8KN/mU78WZisSxc3ou45V0sZt+W3OBJ9J4n
	Rz+JuDTtqgskQlTjIplFiDA=
X-Google-Smtp-Source: ACHHUZ7r5LzCQMVpC3FGu3ITQsbJLJoRLsPva50TRn0LrydoALbhAoruaWc9q873rKtnnkgWSQUN2w==
X-Received: by 2002:adf:dd91:0:b0:2dd:11b8:8aa9 with SMTP id x17-20020adfdd91000000b002dd11b88aa9mr29020622wrl.15.1684304599232;
        Tue, 16 May 2023 23:23:19 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id j11-20020adff54b000000b003062c609115sm1643188wrp.21.2023.05.16.23.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:23:18 -0700 (PDT)
Date: Wed, 17 May 2023 07:23:17 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, damon@lists.linux.dev,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RESEND PATCH v1 1/5] mm: vmalloc must set pte via arch code
Message-ID: <029289f2-1300-422a-8771-1d6b83470aad@lucifer.local>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
 <20230511132113.80196-2-ryan.roberts@arm.com>
 <db1b8b8f-c3ac-4dbb-8b15-125c0929856a@lucifer.local>
 <ZGRyF1nL20wUK2et@infradead.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGRyF1nL20wUK2et@infradead.org>

On Tue, May 16, 2023 at 11:20:07PM -0700, Christoph Hellwig wrote:
> On Sat, May 13, 2023 at 02:14:18PM +0100, Lorenzo Stoakes wrote:
> > > Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
> >
> > Not sure if this is really 'fixing' anything, I mean ostensibly, but not
> > sure if the tag is relevant here, that is more so for a bug being
> > introduced, and unless an issue has arisen not sure if it's
> > appropriate. But this might be a nit, again!
>
> vmap_pfn was factored out of i915-specific code, which probably never
> ran on anything but x86 at that time.  Now that intel builds plug in
> GPUs is probably could.  But independent of that core mm code should use
> the proper APIs.
>

Yeah indeed, I just wondered if the tag was quite right for this but it's not a
big deal, fine to leave in.

I agree the approach is correct, just wanted your ok so also adding my:-

Acked-by: Lorenzo Stoakes <lstoakes@gmail.com>
