Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57F34AB06
	for <damon@lists.linux.dev>; Mon,  8 Jun 2026 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780889532; cv=none; b=qh3uqwq7r7nsuAI/PikJNqElf94zmxPzcZvwy33C4latkBNLCpfOV5ytU1zs3C3G4iGZzc3YVbMtBcUlaz4xflH9NnlfOb9JlgX58mGgAuckR7qyoovjIIrdir2QU8QVQLQD722eJNhZGRyX395WuZaTP83V9NOPxr6GKJYMhnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780889532; c=relaxed/simple;
	bh=Utx4NhQYi0LNoHZCImWDC3d8NFpNYQZR13FETf3nIdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=Xq0du57IpRhfQHD7okxbHqd3zLQ8chakLsrxghOciOeDKTDeZwFf8abQnyiq+ZB2F9KHRvlfOq/nC1g4X+2E9xNcT0yAVgHg/qDiaW6fZMu5yK47+vuW0nsjIjdN5/nfCYdk+oL+fdfRuy+JsYsAwrHvUf3cCg7HzeJA7IUE4RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7NkUUBQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7NkUUBQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c3546924so24069305ad.3
        for <damon@lists.linux.dev>; Sun, 07 Jun 2026 20:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780889530; x=1781494330; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hVEHUeXPEsnvmIwfhxm/kSVMelwzxdhJwmVWg0LJjCg=;
        b=H7NkUUBQOZPILZbNDgT8Jw92zxo7orWqh3u7ZtWiwMQDLKGbLg2iCcnj8SbY0uPyTx
         rW6geZrkTBcEClfxkrBTw8qL/+L5wYub6a44QF81/UAv7FsvRUbARw02ZxKsQBSj9Alq
         zv7tP4snPxDjcdh1eUOLp5cnZS4E3T79GKrQoC8WwnUUwlZoVaZIIsCyKt1NrvXhCrzX
         gkLxTfz9202CVx3dy9kckQ0l7La5w0wRnME+6dYrOlz5+Ldd4bh/RCCNVr9xB/AzYdM1
         mFRsvKc6SONvpsOfsTGDj+P25fpY0ByZnX+jKVPQ9WyK4ZCAcDeCbccjVzixdBaUihCr
         huxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780889530; x=1781494330;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVEHUeXPEsnvmIwfhxm/kSVMelwzxdhJwmVWg0LJjCg=;
        b=h3K4uTluVdeBwWP5Dxw2x3PnidAuXQzekXAHTL6QHuPLeorI83thyEbS8ck4rWxftg
         RqLQyRNunAg22/U9LM9UcVpvkFyIDoSRZ4kN2rIyuvublaeHCfcDjPYCgQxG472KVRvU
         watrst5BvQBxZghaepKXDgt/dQfpvtbFJnz1wgpK7Ghnb12NCGXtTw5bu9uNUBSrmh5/
         45hfVj81X5/c4B7ZQ/RpMco+FOEVF4MmI4Wh00kvpwwxzUQcqAK6iK8PVXjhLxph4VHc
         QlqPvQ02qQ7SxMoI+PKJLRI4NEqxsTeaL34IiZFJbGCy6JQQCvH9lx8M7jMoXeUHVC93
         cubA==
X-Forwarded-Encrypted: i=1; AFNElJ9nchiRyQ4GyB7c8TUi70WBOreoHFKaOgVf1afD+vPksNwrkwDFa5YuQlDomxSNr0U7Pf+IwA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4Uv2ipwwI/KGbDS4UYlmPiAHel8mlUtCflQzHZEKVG4ro3zKl
	7agLHOdbTmOFSwfvO4DC6zEi0ijm9Pon2iUWoZixyViLvXtQmIE4ASUo
X-Gm-Gg: Acq92OGScbMBDn/ji/NA00UHp3vEOCHz47NDaCHEAJvUKHrLZ7cOumhLMVcwKC+KdH4
	H9POdFhczGh0vSOaIMpU4ZgAHF9/QsR34spPmg2SfWjHXYRPFeGFfgFJJd0bgGZDwdw2hESQyz6
	Mx3UVtB17IjjUNykpJGc2UVejtukPHQqbReier7H/MHDSUCUgwAFZ6S9k+buDlPb/18LSHGACoU
	gyaDf1R6gHuzcflmfgtv3XcVz4GpAr6lSUvDD3vWhdJbgeWgxwM02RzIlK8N1QyaxoM+akgzbc3
	L08JoLW+ejL2o/71MJhFZYvSQ6igkf3cQUxTRfVvwNzh3xdjP3GTtfvSl8Ur80scqN1d+ChZSy9
	IBkIWHzhex6gDuJ6fdSqwVeyMibAmlAPx/+ziYs6iy0j2rEEGvSGCLcz0+GUQuhLqME87EDdAFs
	63AbIg33yES72QNr+nY4AuZTBEspRmUeUPGnrc/9EaURTrhhA=
X-Received: by 2002:a17:903:1a10:b0:2bd:606d:b342 with SMTP id d9443c01a7336-2c1e881ff09mr156981155ad.26.1780889530187;
        Sun, 07 Jun 2026 20:32:10 -0700 (PDT)
Received: from localhost.localdomain ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649d2dfsm163430945ad.75.2026.06.07.20.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 20:32:09 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: drop redundant mmap_read_lock from damon_va_three_regions
Date: Mon,  8 Jun 2026 11:32:05 +0800
Message-Id: <aiY3tCGC06k46wOG@debian>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260607173644.93883-1-sj@kernel.org>
References: <20260607-rcu-v1-1-3c9f5995a3a0@gmail.com> <20260607173644.93883-1-sj@kernel.org>
Mail-Followup-To: Cunlong Li <shenxiaogll@gmail.com>, SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Jun 07, 2026 at 10:36:44AM -0700, SeongJae Park wrote:
> Hello Cunlong,
> 
> On Sun, 07 Jun 2026 21:48:52 +0800 Cunlong Li <shenxiaogll@gmail.com> wrote:
> 
> > __damon_va_three_regions() already walks VMAs under rcu_read_lock(), so
> > the outer mmap_read_lock() is no longer needed.
> 
> The function aims to read a snapshot of the virtual address space.  So I think
> mmap_read_lock() is still required.  Please let me know if I'm missing
> something.
> 
> 
> Thanks,
> SJ
> 
> [...]

Yes — I understand this path is meant to obtain a snapshot of the VMA layout.

My thinking was that an exact snapshot may not be required here, and
the RCU-protected traversal inside __damon_va_three_regions() already
makes the walk safe, so the outer mmap_read_lock() might be redundant.

But, if we want a consistent VMA layout here, mmap_read_lock() is the
right mechanism and rcu_read_lock() alone is not enough.  I'll drop
the patch :)

Thanks,
Cunlong
