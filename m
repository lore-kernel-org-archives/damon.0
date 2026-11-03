Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715006;
	b=x1cgd7MgUBKsS2hntrSKBGeTuhB3NLZkTmqzro789jVikwBnigp9vCF6oOF/tHGW2OVu
	 jRUug7YvReuLtzbo5RCufMTdiTNqoihrkHWNg+c4rbJ3Xt9nC/znNYBfIh0lPgmueedN0
	 sq4DveH5NjQIYD3sXNeqlPMjbXpfC07SzNEqd+7dk12mloZi6pyaMMAtCNOsXe4k/8N2K
	 l8gt7916czqnGVU4JbIdUuFukiLv5MJ0FXgyavas3JnRt65rEkCc56C91qEpLu3hj0+25
	 +iwFSbegqxtFe306+cTFqRYpiGlGpqm26ofazO1NWkMF7dXIPWTYSxFTd69OlFSErAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qzg8QxS/frlrk57hvLDahMynox2KuT4SpVk1LZUW0TE=;
	b=0cMYdWctWZrtmhPLBU2vLmlWHjBm3xPZiFKX4tzcPzNA2cNLV2gpH+cmEG8pfVNaOlXl
	 Kw9A8GK5Ov5g5tzeHnKu5wfCKaHGeuffjv5PyeJ4Vpe7IEVGnW66GwhLqtiC7mY9bQ90v
	 2dUZGSQIXrPIvcraEZCu/VBFnidHZ86HnUv1bM9Tmj8pX/8oIeU/oAin7TA30dSE/roTJ
	 T7/ka6HrKqRWGnYcRL2PmXQ1/Hl0pImrFqtB09MavVNJsNRspgkRGZQH0Yh4mJtxfPOPV
	 zmEin5pjjKuHa5Z4i+6p2d+na6SAGRrXGOjOq5NLvaTHAZPb/PWUZgptczMb70OuSCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYhaKxjT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF98F606A334;
	Tue,  3 Nov 2026 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYhaKxjT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6821F000C1;
	Tue,  3 Nov 2026 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793715005;
	bh=qzg8QxS/frlrk57hvLDahMynox2KuT4SpVk1LZUW0TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYhaKxjTGsgSF1PMtP9Gf1F86pV97/YQAze1GGUjGnXWkBFnXZK2xehoeEfPmzJOg
	 USZTxpFDj+mszdLE28PC+I8ZGzOr61vyVArCCUu3jehaqD9R3vorJrbf96S44NYHAM
	 2xs+INVT7guNgPWZuXUSXufObBs8J5RE5ZNUIQEBpMelI+cVrukICzVjIbv1oxMI+F
	 SjAOLIXCTaw3N80xQe1x1abSxVxXx36s2pOLUQqO3Dat3E9fuAnPD+WOFLCa/vCZF4
	 RBFNtDDSnU3xKWmkw72KUcgirP009qCstdh7psQZWr48PBiB4Qv80Sm9S5X99DY10+
	 OCK8d/k+PFWcg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 5/9] mm/damon/{p,v}addr: skip folios already on the migration target node
Date: Tue,  3 Nov 2026 06:09:57 -0800
Message-ID: <20261103140958.115634-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102150757.93058-6-sj@kernel.org>
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

On Mon,  2 Nov 2026 07:07:52 -0800 SJ Park <sj@kernel.org> wrote:

> From: Aveline Noir <jm5905938@gmail.com>
> 
> While measuring DAMOS migration overhead, I found that the target_nid
> path isolates folios already on the target node, then puts them back on
> the LRU without migrating them.
> 
> Skip them before isolation in vaddr and paddr, as the vaddr explicit
> destinations path already does.
> 
> In a synthetic same-node fvaddr test on a two-node x86-64 KVM guest (8
> interleaved runs per kernel), guest-kernel cycles fell by about 29% with
> 4 KiB regions and 90% with 16 MiB regions. Median kdamond CPU time fell
> by about 76% with 16 MiB regions, with no clear change with 4 KiB
> regions.
> 
> Cc: Bijan Tabatabai <bijan311@gmail.com>
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Somehow I dropped my R-b, sorry.  Andrew, could you please add below?

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
