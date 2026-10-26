Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024687;
	b=cFRzYDOZnxVKJfR2kXGMHTlouiswKgWeZ6GGT+OJyTwaRztxllKLtEhCKdEskcUo3sVl
	 NSCD4rYemyje3n+Djj6k1eN5YA90V90PyvHHyvD5uXiQNIbYoNR7keGdSTqKAeVrBfdPx
	 rl3cILbClby+/4aM7a0n0y9SJGqyaQpttdeFRUdtPBrGK2O2VbGJc5WySgimnvXaWcYwf
	 PAWlikHPgIfvqWGmxSl7lXNVSZcwjTdqzqr+pxnhmK3PqX9Tuj4jPIIUmISybXDfOJNC8
	 S6ADYdYCYDHM+lDwiWWmqKTimvAE/z//U8ZJdtNDOLe6gjrlZhfRXFE5hy4FpBmQp6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024687;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xAM1EalDUG4WlKW813AOK6MeXAO5HPHD82lWOVCFuzc=;
	b=TuGCgWu/J/UVhuqKbsxWENDZy/Ya9d2SJdZ3GMJ+Sil2cJVGAVG0T2UA4uBvEnymfhOV
	 m+yhdAeVpkHdF5XSNOjWRt0AzIKT1SADzMrjps9sPFA22/9CIDo+EhXnnSVi5IFXjU1tH
	 V3YlaVyOOaC+RkkdffyqErnBByhfEK2szatOLh9lOupkkhQ0Q+x2FojelzLsjaEPa2+3Q
	 +Eodrai3QF+Jzq59/YU6/aKzfQPc6EHFbIhJjcYsC+eeCYgK/iI83SDDh1BAbDXrJKpvp
	 ekiZCc9p1Z7OxlxyBGQ3VCJZ83UQnybgqqPSvys6UDxWh/YCwznCwkXGvgFNkEavelA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qw5F9F+1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B39606A32A;
	Mon, 26 Oct 2026 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qw5F9F+1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D171F01829;
	Mon, 26 Oct 2026 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793024686;
	bh=xAM1EalDUG4WlKW813AOK6MeXAO5HPHD82lWOVCFuzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qw5F9F+1bzQh2Jmdd11SsFfbmtaWx+5x+ryhkdk5MfzA3ND3OhkbXK6J5zhyhSmli
	 3IuaiJrtvXpUZ3ZhJOf8218YGZDQgl+8xRdyJOwq3WiH18c7ka4Ru0WvqlkE1h3ep5
	 +oa4sitJevsb112yURcRo+pfUjmKlMtnfR4xf8rLvAsozXWRe4zDGgoYdtESQiu4+f
	 HSF6piUolHhKT76zrqWJF2Zu28oeY8FH9Pi3J3C2KBMWF9atUSZshYc8P3LWT18IKG
	 SCBYE9TYwNw6+vUoPmXxi/b2SIFJOmDoHynBimOcKsSZl6GGcorf6JzKpRIme91dH0
	 VLZZFDCBFqXyQ==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] Docs/admin-guide/mm/damon/stat: fix pronoun agreement
Date: Mon, 26 Oct 2026 07:24:38 -0700
Message-ID: <20261026142439.149739-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179301327249.2.17530814278215474568.damon-docs-grammar-2@gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 26 Oct 2026 22:14:34 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> "converts it" refers to the access events, so I think it should be
> "them".  Rewrap the paragraph while at it.

Looks good to me.

> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
