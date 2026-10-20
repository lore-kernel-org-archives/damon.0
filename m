Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512683;
	b=UYNoWBAlilB03XDXqVCXLyQEme4tvJy32FRDZG0a+f1MVv/ux1hu7Cqcrj7QfTFzMet/
	 N4HqMLlvrEgAkKw5FnqWXznsWA5aBuCsT4i/ajUAvZRX5dhcaE2gRBmwAjuzCLg3OJuz9
	 pBzooC9jNJNStiMitVnW9HKh0uUA2jTceKDz2N2kCqmT6xFzTVejuq50Uf9qvlY/O2vio
	 Sp8HtNy2K7qWRdvxK2Uy0dbPs2V8lIC8S8pGtpp9Iyfj5IbGRB4TAAEAGycEjxGiTFLNs
	 OTqnO2v1fLP5u+iM2+PxWJH7fBC6FymO3ZO3FW2ESw9MUsKKAegI5MaZdS3UDjb6voA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Message-ID:Subject:In-Reply-To:References:MIME-Version:
	 Date:Content-Type:Content-Transfer-Encoding;
	bh=FdKpeXgyqOVEtVxGXAfcleh4j7jtKB2IC4Gxgl29KOA=;
	b=nUwTkJKqeXbj2W2uaq4AMKJ1mA3K6SVFWcCRUmgAf+0ZS4pZ5QjoHlJDM0ZQ8QXGq2Q5
	 BImIrw7tkUGuPLOJQLeIar363elLvg/HtyoOpcJpkgf2Ws3gqt+atOxka8yoP/fBkKYNP
	 nyX+1Jd+VAgiuQ3GHkVKv140IhvF7IUhH1IXof60mDSHpB5eYHcZ6f8Bnrzx9VXzEPJud
	 SVG/bkZqNyUvy3fpCUiPBB+nKtyV9rGXM0xol5JSXtZY1AJeG1j+uAD8xyhvn/K7JIONO
	 uSZ11ousdZ8RAnmn8AFpHQM4o6TkDEEcUYFY5mcyzADW4pXJsdMHgpmSXj9pk+cWLUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fEBT4xzS;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9F606A331
	for <damon@lists.linux.dev>; Tue, 20 Oct 2026 16:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D9F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fEBT4xzS
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3ad41b6b2ebso268254a91.1
        for <damon@lists.linux.dev>; Tue, 20 Oct 2026 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792512683; x=1793117483; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:subject:message-id:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FdKpeXgyqOVEtVxGXAfcleh4j7jtKB2IC4Gxgl29KOA=;
        b=fEBT4xzSE8EAw0lhYVwQ48RUMVU98owBBZhvUQkDLRK7jf3QbPIHCzVA5YqA8jovHE
         rQVp8aEJxKEdCDnEMmVyV4dd8zhTmoV2n6NRb7bHPcyzW+vIgxJM5GMuBqxJNYOrU5e1
         //fxMbgRfm8vCfXGCy+uKLZDAWlKqhynP+lHWtcjEKUck5zxzIgwhJT0BueBKlrN7RTU
         a19F3fzj4w3UA6Pxy4vJS61q6Cexr8j4ChFS7U71qgL0s3kkPKHJs7CAw5L1cXRhPRb1
         InFzV0oZYL+coqU0Z2iBTJt+KdXq+qfgK16GMqyG1ZOGYFyHO0cPYOsrvVnvAICyVukM
         ce9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792512683; x=1793117483;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:subject:message-id:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FdKpeXgyqOVEtVxGXAfcleh4j7jtKB2IC4Gxgl29KOA=;
        b=FIIJzLCqE3GBrleYfaHrOZYt5Z3FtxubkPWAbxjKDmxgZIvj3MrHV67J1f9UN9BxU/
         6rywqGSYsYQKfp+VjTcCt61mICyw+9g1TRLz7Bn5aJjpOKcyb3uirEWIAf12U65BNggj
         nDaw5TxQ6pSSOJLKjKY3k/vooHkFWU2agtXqwicUGGej/IkfFsDxJICPM2rL7uIYNPVr
         brWGkn28P7C/gEQasSezzbHXEEmLx5zQLSwuUMujXvW3hJZIVqaKMSWQ92ry4qELDSFq
         Kc6Yfmgabc/3oCl32ghCystE+R+iqKsdwSeDNbykSasgKg/gOYmIoff27P85227mrZYc
         q6AA==
X-Forwarded-Encrypted: i=1; AKwUvBwooZbq8x6UqmPf1xH7XbnbdSsbN/fNfxbAJKu3e0xMociswuNkZOa2ZhWgiaF4K0aFAhrQlA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKdevRbmuGzLCz92HmdrjRG/OlVpIdPfKDlDny6d6UB7OrZgvG2
	2KT3dPzYZ/vGk8GlxKaWmJTRff/USJbiKJX64znrdL2ar9KUOq8bDFHf
X-Gm-Gg: AYBFou1wSK6KVQuKNJrUTZFP8IghaRJ2ZkXe3NJJdOXm7/lm7BiX0wZE0wq+rxBKhPB
	kr6R70aWwrtjJ4T9hSIdgAYnVGTepBs1G5g0EJg3UfomenTpWe0BzTjB9oZnzsl9VOlp74lMTVj
	RM7mjWHL8SmvM4hJ+V8JynhYutDvxqhrkU+K25brEAo1FRCN0QaVZ/v1lOAf2f1Ju4UEk9cIKt0
	yXBs2LkVRXOfrdYPSH1ZTGRxPpiYkzsBsxFqPFHnyfyJyr4WSMc3VGse/25k5x+aTT/gQBdjYH/
	Z8B6qahwbp9FIUAWUQ9LqjpmJ1cIEQ4Skkgz9edCRkwxb+0VQD3yYy/FfpTOyTZLTAiWXe3Hlg4
	+IiVZKOULSEcLwbgHQizdTEASdYzYdPclPRd2YrTX5spa7349VpILunVSXs7U+j5UZKW3+at97x
	fCHgoridd1GBH7unafXko4xY7HaLT2DFbNqzBSKql/Hc063onXwGIOcgzkR6VxJxEEA8ZVvdeQb
	pcPhzD+7mfAcmshdkoKpwGrKCNokIO0P3fRl3UVz+rH9SDtTSYgmvr0uMwKYw+n3a9kbZMW
X-Received: by 2002:a17:90b:5345:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3ad64bd668amr1739707a91.32.1792512682581;
        Tue, 20 Oct 2026 09:11:22 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9942956sm8903911a91.1.2026.10.20.09.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:11:22 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Message-ID: <179251032453.2.9019098760697634552.damon-quota@gmail.com>
Subject:
 Re: [PATCH] mm/damon/core: remove unreachable damos charge_{target,addr}_from
In-Reply-To: <20261020023958.108276-1-sj@kernel.org>
References: <20261020023958.108276-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 00:07:00 +0800
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi SJ,

> Catch the corner cases in damos_adjust_quota() and reset the pointers.


The patch looks good to me. I tested DAMON_RECLAIM stop/start after
filling the quota on x86-64 KVM and everything goes well :)

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
