Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717140;
	b=vA9OvUI3LgubKSAn2qPCsYF/fZYrzVEowiYUyywOMI88k2zdLsBPnHFDnalA0ZHNWEKP
	 2CICi18uLugdJfCJd4be7ZzC9zdnKRatnFxcQk96AOBVQmZMRpBX0SMN7og2WsN01mupQ
	 xe3P05xgLrQV0Ke7AHBFtWSIJnaTW5UisRQA9Z1fxKyIwMVPOVU7CvlP9A9yILhSBlFFm
	 Ar8idM+1/wNZxn49dsdUXazJEVp8WHReqGV9dmTYiJBE7Ai+Nfji86eAbLqqvDHXhZgGl
	 nOcp2YzXFNQs1RO0x0IkKPfPRXUdAFWO/Wmde5jK8qQ1I3dREAAvYN/zCjOgpYj//Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717140;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BCL6ienR6vsHs1rddhFc4AKsyfVTg4cYiIABXe66O0M=;
	b=ktelS7XipNt/tBw+sA8lNa9EfK8GD5jLG4b2ydeG54Uk8mvg5QIgCW6A40d/MR8rYuHh
	 kxVSb2aDnNUm0zivBa/flTUMfu+ZWHWnPL03nJz49wZL/N8c9El2ZKry8IiI1wAUxUBRR
	 k8j2R2XNjTVK2KwIXRCMKf9AEqAR3HYa2uZ3z0E/Z1zZbnOBrncZ8mBRYw0KZxJVuDnDh
	 FnlpiChqbqmE49xuEl7ZrmLlBR7cZ1VTvR8iDylChC3XsB5iVhda327OLCOw5xawAaQgv
	 BgvrqWHVmP16HTS5OoPY7mjzg3+Ng6V77C94hcPUleRN0q8kkK0uXw9+4BV1NaN/K4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZY1WNr25;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC6606A326;
	Tue,  3 Nov 2026 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZY1WNr25
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E123A1F000C1;
	Tue,  3 Nov 2026 14:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717140;
	bh=BCL6ienR6vsHs1rddhFc4AKsyfVTg4cYiIABXe66O0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZY1WNr25RicuYSX/YFwdj8SN4PIN3yIx3Q5nv+2Ki/G1ymiibwii3bPyPf294f7TH
	 H9qx7tBPdAIRSKB81305msBlTqyTu7f+RQdSm2gySplVyZ4bfpguGKVJkpweDMw8NX
	 9V0bXu7zouY+vveCWfbmLwfQDTHcP4WDiWj2AJqeCuWKSxs+EuGM0fzk4xjnHLKURa
	 UQEHlUrJoaldjBAnRnk7MqsJaj7FqPfOJ/4H2/8KjH/RxRvveyqx4Vr89RuJ+P9Dpf
	 1IB3q0/a9XULP0BL2YuUjwuyLb8W25z20yA64cXEaumZPNq+uD5sZqtpiPaZN0Ir4z
	 c2GjtjbqSrT+w==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Enze Li <lienze@kylinos.cn>,
	damon@lists.linux.dev,
	enze.li@gmx.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: use list_{next,prev}_entry() in damon_{next,prev}_region()
Date: Tue,  3 Nov 2026 06:45:32 -0800
Message-ID: <20261103144533.87946-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179370190119.71013.18301574509097172702.b4-reply@b4>
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

On Tue, 03 Nov 2026 21:31:41 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi Enze,
> 
> On Tue, 03 Nov 2026 18:07:14 +0800 Enze Li wrote:
> 
> > damon_next_region() and damon_prev_region() manually do container_of()
> > type casting to fetch the next and previous region from the linked
> > list.  Use the dedicated list.h helpers, list_next_entry() and
> > list_prev_entry(), as damon_first_region() and damon_last_region() do.
> 
> The change looks correct to me.  list_{next,prev}_entry() expand to the
> same container_of() calls, so there is no functional change.
> 
> That said, my understanding is that the kernel generally discourages
> changes made only for coding style, outside of other work on the same
> code.  Documentation/process/4.Coding.rst notes that "pure coding style
> fixes are seen as noise by the development community".
> 
> SJ, what do you think about this kind of cleanup for DAMON?

I think whether it is noise or not depend on each change and the volume of
traffic.  Let's suppose a patch for a real trivial change and there are many
patches for critical bug fixes waiting for reviews.  In the case, I think the
trivial patch should be deprioritized, and we should discourage sending such
patches while the urgent reviews are done.  If there are bandiwdth for review,
it is no problem.  Nonetheless, I would dislike patches that making only
trivial cosmetic changes that doesn't really improve maintainability.

I feel like we have review bandwidth now, and this change looks like a
meaningful code maintainability improvement to me.


Thanks,
SJ

[...]
