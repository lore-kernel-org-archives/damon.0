Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBCB143C50
	for <damon@lists.linux.dev>; Thu, 13 Jun 2024 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285265; cv=none; b=Geg19qSIEEKeYLIKCJslJRRmFr3RGO0lj94LhefXKqVgmlWL7OsoEaPlhKas2s+MSXoQa7O25vHexDtkoR3v3ETIzXXcbS80+lP/PAxAcxhOWAa2AC1pZa1OIRC0j1rxY/8xPFD2nZ9UA7AnuIiJznoIN3MslnDgfyt753EbPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285265; c=relaxed/simple;
	bh=XMLRI6kBv0aR9hMmaRg4V90yMlpqpImy5EvudAnSBq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1c2VvHeUczlF/8/wTzeKxTpDw5OoKF5GYUx8uGa93kARgWQ38vomuduZpirDw3dezZXgzjv+zZdhAmLCNmK0YOwNjQE5EyXd08x6zq4fxQxhxTVUsmAreeYbqS8XpbZeZ3eeXCsriS58E4zKXaagZEtOlsfDNa6gJdkuBCiLlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-f1-666af3cb7f2e
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH 0/8] DAMON based tiered memory management for CXL memory
Date: Thu, 13 Jun 2024 22:27:26 +0900
Message-ID: <20240613132730.650-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240613131741.513-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXC9ZZnke7pz1lpBrNnillM7DGwmLN+DZvF
	/Qev2S2e/P/NatHQ9IjF4vKuOWwW99b8Z7U4sv4si8Xms2eYLRYvV7PY1/GAyeLw1zdMDjwe
	S0+/YfPYOesuu0fLvlvsHptWdbJ5bPo0id3jxIzfLB4vNs9k9Nj48T+7x+dNcgGcUVw2Kak5
	mWWpRfp2CVwZL9ZHFSxnqzja38zawNjP2sXIySEhYCKx8vgvdhj79LlXzCA2m4CaxJWXk5hA
	bBEBRYlzjy8C1XNxMAtsZZGYs6GFESQhLOAjMevtexYQm0VAVeL0rh1sIDavgKnE6hvn2CCG
	ako83v4TbAGngJnEum/3wXqFBHgkXm3YzwhRLyhxcuYTsDnMAvISzVtnM4MskxD4zSax8vtL
	qOskJQ6uuMEygZF/FpKeWUh6FjAyrWIUyswry03MzDHRy6jMy6zQS87P3cQIjIJltX+idzB+
	uhB8iFGAg1GJh9fjWVaaEGtiWXFl7iFGCQ5mJRHeWQuBQrwpiZVVqUX58UWlOanFhxilOViU
	xHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhjdzx6QWcPmspB35tqyWut9KS7aHfcyWJ4F+F0q
	5bfw2XB3CovB1QVX9n4PfT3LtGjBh7dmJ8QMfD8Zf5Zmt3z36amaCuv8G5b6S7JfLE4/3L4s
	5LPqauXk3c+ExE7e1yx4fKN9SedeheXbBLlli3p3cr7TfPqCXX2HVDVj//lfizPXfwx+w3xO
	iaU4I9FQi7moOBEAv0xGa34CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXCNUNLT/f056w0g/Wt3BYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbNF55PvjBaH555ktbi8aw6bxb01/1ktjqw/y2Kx+ewZZovF
	y9UsDl17zmqxr+MBk8Xhr2+YLH5vW8HmIOix9PQbNo+ds+6ye7Tsu8XusWlVJ5vHpk+T2D1O
	zPjN4vFi80xGj40f/7N7fLvt4bH4xQcmj8+b5AK4o7hsUlJzMstSi/TtErgyXqyPKljOVnG0
	v5m1gbGftYuRk0NCwETi9LlXzCA2m4CaxJWXk5hAbBEBRYlzjy8C1XBxMAtsZZGYs6GFESQh
	LOAjMevtexYQm0VAVeL0rh1sIDavgKnE6hvn2CCGako83v6THcTmFDCTWPftPlivkACPxKsN
	+xkh6gUlTs58AjaHWUBeonnrbOYJjDyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZec
	n7uJERgDy2r/TNzB+OWy+yFGAQ5GJR5ej2dZaUKsiWXFlbmHGCU4mJVEeGctBArxpiRWVqUW
	5ccXleakFh9ilOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwTmXq03ecE8G8x94o5Ngh
	3peSi950PTpR+THUf97byGrzLSwr/ERev3iU8Cjo4lrP1wb8fpr1Bq0JSZvX3W5vr/1f1tHs
	Yji7f5bnPuvnMY+TlZUbt3spPdkYl8u9OTV36wPO67fEcr1U+I5JZB3wV7/d2iWoZrnA95L8
	y5vC53WdhN0uigopsRRnJBpqMRcVJwIAwTMx4X0CAAA=
X-CFilter-Loop: Reflected

On Thu, 13 Jun 2024 22:17:31 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> posted at [1].
>
> It says there is no implementation of the demote/promote DAMOS action
> are made.  This patch series is about its implementation for physical
> address space so that this scheme can be applied in system wide level.
>
> Changes from RFC v4:
> https://lore.kernel.org/20240512175447.75943-1-sj@kernel.org
>   1. Add usage and design documents
>   2. Rename alloc_demote_folio to alloc_migrate_folio
>   3. Add evaluation results with "demotion_enabled" true
>   4. Rebase based on v6.10-rc3

Sorry for making confusion, I didn't add "PATCH v5" tag for this patch
series so please ignore and see the resent one.

Honggyu
