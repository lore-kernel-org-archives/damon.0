Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279074519B9
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467693; cv=none; b=FKrnkUahTQJ/VoaeszEx+GQLg3eVCi9wvJNCrO0t3iVJIcisKXVT4+xAKNXiaCNs+jGcpBNJGzK9XZIEEnTuIdeefen0mvJ/pC6KjIsI2N47TWx77TdZTvoQvBWpXpC4JsDimkzOOV7KvkK1/IYnr7U1G3u+7bCdEy+PxGh0vgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467693; c=relaxed/simple;
	bh=ygdtTsylkmhJCueh20hvfX8OiBBSzXTaE+r5DVi2wNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZepgaUxhHwkM5BuFLW/+36dnME6D6YwSsl7Jdyq3Kp9EcaMenEYX9BQy+zZF7xZvniPi+X7xparGLgxw3J72zB9WnU4LYR3Co7srv7KUfLJ+2nbq671j677XZ/h4ooJxsip8wOA7kkApXaGnNTFh83oaoRl187CmRJPF2et1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQQreP+d; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQQreP+d"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so2519464a12.2
        for <damon@lists.linux.dev>; Tue, 11 Aug 2026 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786467691; x=1787072491; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wvvwdmlhQN6SCdBOGflAFbjpJPXCG4Pqa4APAhlzpLg=;
        b=dQQreP+d2NjqG6BvHONGc5No0F9FIDl47T/TG4Hhj1kbHzID8zLeuqKFemeNc/Uk+H
         2A1e3BMbpI7+GxNa7SAD2ydBJ2TnyuNhhqSh9dYVBmEm+Kz2mOCThiDKMuVBjAHfO5W6
         oLANXqNl2T1nokLs+p+QjLbAm5ghD8KDtw3M+3yYUpbMFXtjoPMhFTx5Y1/P4BHl80S7
         urVo1PIJgJIOU+HRayVDmutG8Xw/gTl7quPOilYwLGvhv+SQB/xqUwTUEeYvcTE70eKy
         zUkfYSKTS0q+aNhPONF7PbhyHb4J3lEGvLn6RHptQV3pGWP5YAg7Hvn87WSe/06rPqd8
         vbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786467691; x=1787072491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wvvwdmlhQN6SCdBOGflAFbjpJPXCG4Pqa4APAhlzpLg=;
        b=V1o3sKhz8setdc6luO7+6kTjypS4/okdsprYkpgdxI5uYcOwAM9V1DOHmQM4PB1BAs
         CVwYxr15r60VvHVsThcnRuEcVspNFBT3j+sAb2zuPFuh5UR6AnqyEn8q+oiBbrnd+a4h
         0weqzlb5ZGTK+lZCvo0PqIEu43PgoCRPpges8OqdAtwcmY3siT1muGWWJHcFbvobTiws
         EO21yWrib79U1HFWNqVv8Ntq6eQX/QZSHjBNIT0uwwQd+Rz1BXwuc2NYAuM6QyN0ykHK
         rlgm7BjuiU4jBmIdyaoAOB03Y3Pzw9sN6K7JZivcIeHCkoYW9Qh2lh+iK1V0F8Nb/29g
         JfXw==
X-Forwarded-Encrypted: i=1; AHgh+RrZUtTpBjIL3QrWRE9LP8aU8oTDXWA1FLzqCAqZVGBz/D39Gf7z/RcU/BgZKU7nJSMRIsifJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ8dOLbn2JKxej3BO121/TRGDHvpTS1DMHAWvQz6jFU2ohEF9K
	R3fZSS3PaswUobB8VoUVT5gN6Qoy5pENWlXXrODVvUum/C0a4yOV4FGz
X-Gm-Gg: AR+sD10YvmZ0o/B8sgwGUU/s35DV/TkWd9dXWfeoxwmUvhUjCqZ6RrcvrFOIG7Vc/TU
	PbqU2BcItA82HfyRrZ8F3BGOFnL6J92qJjvInRbVvXGIBEjN/456PRFyqbgyrgF3f7qL+H+M7eE
	Ff8YnTuoj4iU53374Qg1/mUOG/1lY8qDD5m+pewGwkMyaqwjGYe0cWpb6uV6ISYHbrC1wTBKv/T
	B33QNR4HVAKTMPh+XBD/qf6k0iUWhCnZD1Hylyhul0rz8ckX91WPiFzqTb7fYew7UuUp08qBzrB
	jUHM36p8J7aTTUt/8/V7RPxN+jTvsPpRPWYg4/ityLt/G/C5yrhjYk7foI2t5gedefH8FbvrcxC
	NiOapRyv9wJX2mtlVQ18r/kEWkq03icR90p7MyF70YruGVrmSt8d0KYrXWXDBp5ER9lLcA2hBEd
	udFfXdN6jBaCOSgp/LypbdhaJFYJbqiCHPrF8BisXq8keFdYjCsu1n/opri9ycYb8=
X-Received: by 2002:a05:6a20:430b:b0:3cc:1dcc:b079 with SMTP id adf61e73a8af0-3cc37db71a8mr1669990637.19.1786467691257;
        Tue, 11 Aug 2026 10:01:31 -0700 (PDT)
Received: from celestia ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6d726f1sm1912651eec.26.2026.08.11.10.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:01:30 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/3] docs/mm/damon/design: accurate semantics of nr_snapshots
Date: Wed, 12 Aug 2026 01:01:39 +0800
Message-ID: <20260811170139.32342-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811134634.4407-1-sj@kernel.org>
References: <20260811134634.4407-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Aug 2026 06:46:33 -0700 SJ Park <sj@kernel.org> wrote:

> On Tue, 11 Aug 2026 18:18:39 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Change "tried to be applied" -> "tried to be completely applied" to
> > maintain consistency between the documentation and the code.
> 
> It feels bit confusing to me.  The completion in this context is for "trial",
> not "application".  For example, someone might wrongly think the number could
> be incremented even if a scheme was "tried" to be completely "applied" to the
> snapshot, but failed due to a quota.
> 
> What about "completely tried to be applied"?

Thank you for your clarification.

"Tried to be __completely applied__" means that even if only a portion
is tried, it will still increase. "__Completely tried__ to be applied"
means that it will only increase if it is fully tried.  Right?

I will change this in next revision.

Best regards,
Rui Yan
