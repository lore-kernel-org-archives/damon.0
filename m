Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAE266577
	for <damon@lists.linux.dev>; Wed, 23 Apr 2025 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745386730; cv=none; b=n9wm1JiUr3WeeDKoSk1ondpkH0Cc6/vnaRA73t8AJQ//CTqBvVz5iWymk+QAjvEoLYTdpmTAUA6y490CX9KpIxwHtxFZ0lKBen8gHhmuU7da/AwlcveKacbldDvTbYe98JUixRJVpx2FnOzThHhLJ075JNwpV2VASRNCwEdpzsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745386730; c=relaxed/simple;
	bh=VqjiVsUgDavc4EcC1HZnrZr1FyxyHXrwMTCOlnrM7Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DttnPec19z91UlRyHIwoeZ4+nU9SGkmstMlP0TR+2vozvMklaP8TqI4rpu4xHWN6FxqHGB0kRYe4YFSp+wp1Amewcwle44CvdKmJuGPryFiYIf+YjDIEjSAViG4mlNMHlVANqD+j3gdQ4vvkc6RZFSRcEhwP+33jww+Mp9uqk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L1bUsVwf; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1bUsVwf"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c14016868so5961533f8f.1
        for <damon@lists.linux.dev>; Tue, 22 Apr 2025 22:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745386726; x=1745991526; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UhDYN3CF9rLRAKM/r9oz1rE5oym2M8ZTGRvqaYVr2nQ=;
        b=L1bUsVwfgaCoUyh9Y3GxuLkffM5jHXdoJznPPl+mtJMRumCzvX8ctWiApx3o6JRKNU
         ZFo0ZVP+Cy89ebevgIdaMXamT5BjOvBuq7HgaAX+72qUjF3BSTcXIiv2hh4v2RXToDh0
         7Dw0LgbCiqIJYseOG8RI7lLuKR6+edy0apbXPyXLTmmPg5q//wg7bWmN8ZeEdysLOkJ0
         j5lcdaVRYH3KUDH35eXaL3BmocSzbk1wfOMLYB6kOMqpYrB6b2ikijyhdNwgMqBYCqCn
         Tc8siDKrRi5qKvyjd/Y88/GOktBOHjBsRe0gEtjzn5dyB1DCcUGfs112iWUJist+KfTV
         Bhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745386726; x=1745991526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhDYN3CF9rLRAKM/r9oz1rE5oym2M8ZTGRvqaYVr2nQ=;
        b=ajqo2srUnJJm3kO01ELNQw7tn8tTFZ+rUxv+fac1/Oyo80eh4ZFt68JizVAUepZf8M
         fsnjERuOlO+N96Rerdu+ZuqiF1/13uLDc9XeRxSjf2Gs4JfVV4CNcYAiPkvV/QsoRS5E
         zqmk9iVjoXAF5UBH1rTb9mP/X/OFh0uyQg+Vsi5D+dN2uxfzgrsVqan7wdUC9qe0/XGJ
         HbDUO8AkvlIeuu6qp+eR6L7/8DQRT3n5UbKKrYonQiMMIfjP51khHTAI2Rv4DaYWA10f
         ngLryb4Hro5tbeN78Uj57XnY5gpLGUW6SAk6H8vMOXyshPUx+09HphMWTBmRfPF2j2KO
         LE1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3pTVL6iFpkdBXj09T9rmWNY/9ljREAeJMtnF9O50Fmcp4aFjXGs/QogbqvCb2AVw1N06/cg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxo1wNTqMLG4/RbR94w6bXcZA582cPrF7tN9+IL7w2djWvejkYs
	iv3afolK9Hj9GHiLcHEusM+73ZKaZ1bQdOVVJLcBHpRe+VhJyo+QXuqvN3xF0iY=
X-Gm-Gg: ASbGncug73OJ/vo30M9tfTsAQwld2hDA6Uaf9atUUa9UZeJdEyogF7Y1Lwnw973OTx0
	RI+7RfdN3dLUY2CUObAXRYuH9kqC60YAgPbCyF3Aek1E03AbP1H4omEnzhAbLgMsk0mBWZnLG51
	SLzUZdXSwi1qrCEJ+m45+356tyaj9C/PyamDS8HT0Ru0w6S7j+PMsLwiFJle1VJCQHRmwIi4fLj
	OG4gYwUGbOBBTPvZ60b6VG2jL2GwQjjBvhBCY9eh4esl+A7w3KMRbxL/C1o2wFndMr2Qf9gGRhq
	vAeRd+G3SP7GiYwgRsDgUjJkcypqRKAxMcFRuJt7YRwWTQ==
X-Google-Smtp-Source: AGHT+IGcspVXZAcwag6irceQMFNsXqq7Yshy5NJ8XuJJUj+Dz3fu1dCOyXWn3Bzyt34StqtqRvHlcw==
X-Received: by 2002:a05:6000:1862:b0:39e:f9e8:d07d with SMTP id ffacd0b85a97d-39efba3fe8fmr14038216f8f.20.1745386726423;
        Tue, 22 Apr 2025 22:38:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-44092d37332sm12282925e9.30.2025.04.22.22.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 22:38:45 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:38:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: using kmalloc_array() and
 size_add()
Message-ID: <fd372c23-1bf7-4c93-a51d-ba5dad255b04@stanley.mountain>
References: <501ea9b1-017b-4517-8de4-7056803e7127@wanadoo.fr>
 <21407408-78e4-48eb-8296-fcddc702ae25@nfschina.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21407408-78e4-48eb-8296-fcddc702ae25@nfschina.com>

On Wed, Apr 23, 2025 at 10:04:56AM +0800, Su Hui wrote:
> On 2025/4/23 02:50, Christophe JAILLET wrote:
> > Le 22/04/2025 à 20:23, SeongJae Park a écrit :
> > > On Tue, 22 Apr 2025 13:44:39 +0300 Dan Carpenter
> > > <dan.carpenter@linaro.org> wrote:
> > > 
> > > > On Tue, Apr 22, 2025 at 01:38:05PM +0300, Dan Carpenter wrote:
> > > > > On Mon, Apr 21, 2025 at 02:24:24PM +0800, Su Hui wrote:
> > > > > > It's safer to using kmalloc_array() and size_add() because it can
> > > > > > prevent possible overflow problem.
> > > > > > 
> > > > > > Signed-off-by: Su Hui <suhui@nfschina.com>
> > > [...]
> > > > > > --- a/mm/damon/sysfs-schemes.c
> > > > > > +++ b/mm/damon/sysfs-schemes.c
> > > > > > @@ -465,7 +465,8 @@ static ssize_t
> > > > > > memcg_path_store(struct kobject *kobj,
> > > > > >   {
> > > > > >       struct damon_sysfs_scheme_filter *filter = container_of(kobj,
> > > > > >               struct damon_sysfs_scheme_filter, kobj);
> > > > > > -    char *path = kmalloc(sizeof(*path) * (count + 1), GFP_KERNEL);
> > > > > > +    char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
> > > > > > +                   GFP_KERNEL);
> > > > > 
> > > > > Count is clamped in rw_verify_area().
> > > > > 
> > > > > Smatch does a kind of ugly hack to handle rw_verify_area()
> > > > > which is that
> > > > > it says neither the count nor the pos can be more than 1G.
> > > > > And obviously
> > > > > files which are larger than 2GB exist but pretending they
> > > > > don't silences
> > > > > all these integer overflow warnings.
> > > > > 
> > > > 
> > > > Actually rw_verify_area() ensures that "pos + count" can't
> > > > overflow.  But
> > > > here we are multiplying.  Fortunately, we are multiplying by 1
> > > > so that's
> > > > safe and also count can't be larger than PAGE_SIZE here which is
> > > > safe as
> > > > well.
> > > 
> > > Thank you for adding these details, Dan.  I understand the
> > > size_add() change
> > > can make warnings slience, though it is not really fixing a real
> > > bug.  So I
> > > believe there is no action item to make a change to this patch.
> > > Maybe making
> > > the commit message more clarified can be helpful, though?
> > > 
> > > Please let me know if I'm misunderstanding your point and/or you
> > > want some
> > > changes.
> > 
> > As sizeof(*path) = 1, maybe, just change it to:
> >     char *path = kmalloc(count + 1, GFP_KERNEL);
> Maybe nothing should change?

Yeah.  No need to change.  Sysfs buffers are always a page size and
count is <= PAGE_SIZE.  Generally, it's one of the pieces of trivia
that people should know.  That's how sysfs_emit() works.

regards,
dan carpenter

