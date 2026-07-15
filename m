Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6295D31A07B;
	Wed, 15 Jul 2026 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123809; cv=none; b=GL1TaK/VkTOSYU2X7dFVSYu/KzvUuH1JJyZenGoeNqlr636XqZXXYa/MyOBcZ/ZdE3JtIX3l/5H+jK+oIwxM1E38lQPj8sOHVQa+UhSNLtOzG2LRtiieoR1UksIZ9p/4K7RpP+FuExchkUnq7adJlZALywF4Bzu0f7qJxeL+kLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123809; c=relaxed/simple;
	bh=ZNdQZ7sGJ+viBacgQQzza1Ba3IitugMxwBpUUKKTwag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPN8doatj50QrXDLL6exXBOEmyvJf0VT9eAsRFLJAq7oMlIxuzN9up3jDMUYHRqwS/8FTYEsZOaIOD4Nujed4gJwfwzoFJgc2DdoH0ExTgoe1iHJnfAiYvDgJGZW0FzA5ePMIMr05hYOQIqszcrQfHxTIa6ed0hD5oUBDYCfX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDQO1uZP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDQO1uZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFBF1F00A3A;
	Wed, 15 Jul 2026 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784123807;
	bh=LCsWQYFVNSg7uA4Hso/40lGt3fnLGJdyXFxUHGfslFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iDQO1uZPO5gMGFgCWTiFdeuEcYz30Fhnyxx6qhAcmhYNOWvoVEUFdDcg9u2eHONZX
	 5MNwywrFbmqAQenF4hqn/sHiaXVso9iQoQ1YPisjATK9Qrrb1nORCsvTGtrYQy5XIi
	 H5mDwM3uSkqigHIrLD8RknbAtgxiOTVGTImgCQr5sqpUWpcMNlCetcdPr1Knd41mm5
	 afqMg/N+d74EWsb0ALLKvioJsQAZ5x/vyD4BLmwwsLcIpjqxM5c9FsTXos5rVFvVzS
	 saS4F4hURs6ixYG2GkHZl9a9CDHu2lvoZXXNrEsZJTx3RZXqu9DTKhE8HIm7qOLlJM
	 tdAc9iRzUfGGw==
From: SJ Park <sj@kernel.org>
To: Song Hu <husong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] damon: update outdated comment about DAMOS filter handling
Date: Wed, 15 Jul 2026 06:56:40 -0700
Message-ID: <20260715135640.84147-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260715092634.1450702-1-husong@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Jul 2026 17:26:34 +0800 Song Hu <husong@kylinos.cn> wrote:

> The kernel-doc comment above enum damos_filter_type states that only the
> anon and memcg type filters are handled by damon_operations (and therefore
> accounted as 'tried'), and that DAMON_OPS_VADDR and DAMON_OPS_FVADDR do
> not support those two filter types.
> 
> Neither is accurate anymore.  damos_filter_for_ops() routes every filter
> type except ADDR and TARGET to the operations layer, and the VADDR and
> FVADDR operations (the latter being a copy of the former) handle all of
> those types through damos_folio_filter_match() / damos_va_filter_out().
> Update the comment to match the code.

Thank you for updating this!
> 
> Signed-off-by: Song Hu <husong@kylinos.cn>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
