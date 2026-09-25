Received: from mail-pj2-f21.google.com (mail-pj2-f21.google.com [74.125.227.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7A44CACB
	for <damon@lists.linux.dev>; Fri, 25 Sep 2026 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321378; cv=none; b=YfGK9+hVKJSH5qVMSq8Tf4sWOaOLqMqqNNddyJUXj6WCw1Adr6dhl2+xdwF3cuVQsrKRAMVFxOSbmaOY8dPjI4LixgXsCobRVz5ROWqyVUdzrjNpscbUBXqcYj9nXb20HNWnGsnvXJlY5JR6ria1/jC5tUz8znckX4wmug0jUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321378; c=relaxed/simple;
	bh=29x6ry6DooqP4iiczSQvTQsuf3lHHuZl/pxLTMWhZ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bff6VmYRBB4eO86yXyGfoyEJf5E7bhelP5MoXUxaYTbk0xMeuOk/4uT8OgOE3J+gsNriekw5Omo7qugpyreDTvhXaNXP7foPWQxrLyNMY3Bxu57D/kASoNxgDhCwREjtRcVIgVabzI1phW/Iy613lhQNZ4/i0haT6K0ml2vUcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTYsfua2; arc=none smtp.client-ip=74.125.227.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTYsfua2"
Received: by mail-pj2-f21.google.com with SMTP id d9443c01a7336-2d747f0b25dso3344335ad.2
        for <damon@lists.linux.dev>; Fri, 25 Sep 2026 00:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790321376; x=1790926176; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=29x6ry6DooqP4iiczSQvTQsuf3lHHuZl/pxLTMWhZ2c=;
        b=mTYsfua2JlO0nadWfNNP7zIwxxyvfYNY1CH3O/IYeLFGhvTNhsadEVbsNUodQKKpou
         6r0enrWe7g3k1WvSOY+pMsRegZb0hZvKB5M5gVkbY3q3uXL+3us31TPB4MKyZqrID/Tg
         5dMvyeEisLO+Z0EnOrmZZnstcV3z7lgO+aWXt+NOK3iJCF0gWvuvRuvDg1xEHAfK/3jU
         aJalylsbqIML2LVoX5IuWLpo4GoKMkfMoFBD+4A2QyC3ZprvUyMI+Z9f8jnejhXF6r6D
         +xjdKe+4ODn23gmhQ0VBcI9zi6pbGGUCw/oNdB3HmBRwzYTaAgUcpJepFvZhxyZB/3hW
         DKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790321376; x=1790926176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=29x6ry6DooqP4iiczSQvTQsuf3lHHuZl/pxLTMWhZ2c=;
        b=u9R28UEOEAvvs+AlBgIFEgeaNMOfYg/z1alEwOahwZr3b19mHyIbMc6tBIh9x5qOeW
         +13e7kJOkRdz0KP0lXw9Z2SiF7ZUnDnxHAIXfLlnOWVFKaUDlrC+kr/JBluHwmRvjIhv
         Mu6VOh8os58+vZLGKMuNBIdtuA8aTw5cRmjgpfQWX12oznNcVs65Go2y9/YgxptrJUcC
         3iQ3RUIZnFwc0GzMnZN8P2UiTnH8DsthdUvQFPU3bVxC0eI90hb+xyae6OUV/k/kBAvP
         iTIwJgR9DkdqVp4t08RjXoO1bjlixLP+e+zk3+jlfs4C0DReEqgAVTaciNMKg4di9C3N
         tk4g==
X-Forwarded-Encrypted: i=1; AKwUvBwdCxc7bsyk1bMUA2ETe5HnMbjKLH7fVKbG8eLAMpr17MpmjoXGHHMKLcSE8Q9q1FhVtzlgiQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nPtyTXgLThcOAEVndbftIuXSFL1YqLmcANrpUQM6zwthl4dO0V
	DHkBb0bwYTiI+DPejVTs+v6erUFwGiDfMcOzjL/6eYK4BAZPtjxLnH39
X-Gm-Gg: AYBFou0/D1HFYxvjnSK7s+9EmE5IeQEBOuSx3GKKjRItXz/hYyNhLlXGYp4vn7dCFsb
	WVyJc28l7xJFOS/WlHT89NMSTmLsGECa41bysH8Gc6MwfP2i8b1RcKzfDGA7y3xuTTVP5md/0VS
	ImDUkxnlSLxwYAdgEvZ/xnHW8a/tZiZhbV8EnwQDEzFQN2ayCZvDcc/eOV3PY9ueBerbpQtoTPt
	yynr4B3kIHAgD+XBL+MZMXr75xGLAUNpHaK0qL+7jxOr1JqIUWX+TQs4SJAO4JX4XtpocgDl/Dn
	S2i+AFJPKZSoJLrK78nctCE+Ey9jMKCQ5E1Jf8G4/Fs0VoHDb6SSnzSPyEqQopHccKhNaejgFF7
	qhkGA+2pDxREhPKAMELmkHKiz/ILSSTV0fJlTjAZ3GDbpDQqelD46Kp2jeZhBpHcnu9ffkAfyPl
	4rEUd76BvO7VoFh7nu03O/uH2y4ntgCU5E5hgSb1AfWgPfuBbxQ1+lu19H7SfUT+/Vj7JBp1W44
	VSuY5faVPhHRP0225uVLfYPcOuIwlc1zoBfCkJPONVO4CTvpB6O
X-Received: by 2002:a17:903:1ac5:b0:2dd:c100:313c with SMTP id d9443c01a7336-2df7e24f8f6mr44115705ad.56.1790321375940;
        Fri, 25 Sep 2026 00:29:35 -0700 (PDT)
Received: from localhost.localdomain (vmi2317699.contaboserver.net. [85.239.239.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91444814sm5797475ad.59.2026.09.25.00.29.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Sep 2026 00:29:33 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>,
	sj@kernel.org,
	mst@redhat.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Kairui Song <ryncsn@gmail.com>,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com,
	baohua@kernel.org,
	xueyuan.chen21@gmail.com
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Fri, 25 Sep 2026 15:28:52 +0800
Message-ID: <20260925072912.39496-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <9f63d60c-913e-4e79-9d28-890dd48ef713@kernel.org>
References: <20260925054408.10431-1-lance.yang@linux.dev> <9f63d60c-913e-4e79-9d28-890dd48ef713@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

Indeed, both directions are very exciting. virtio-pmem avoids duplicated
page-cache residency, while DAMON with free-page reporting provides a
practical path to reclaim cold guest memory and return it to the host.

This connects closely with the work we are already doing. We are continuing
to improve our DAMON-based experiments, and we would also like to explore how
DAMON-based memory reclamation can be coordinated with broader CPU and
resource monitoring.

At LPC, I plan to bring detailed data and discuss the follow-up design with
everyone. I hope we can turn this into an executable milestone, bring the
related ideas together, and try more scenarios as a community. Everything
looks very encouraging and gives us much to look forward to. With SJ helping
coordinate the broader roadmap and everyone contributing, I am confident that
we will achieve many more exciting results. Kernel work like this can continue
making the world better.

Thanks,
Lian

On Fri, 25 Sep 2026 09:04:41 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> Free-page reporting makes much more sense.
>
> When I was at RH we were looking at this issue as well. virtio-pmem was one
> way of avoiding the page cache in VM entirely. But it has its own limitations.
