Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265B02EFD9B;
	Wed,  9 Sep 2026 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964998; cv=none; b=JpWwZ9N7hT+J6AsbFro6A1R2gfcpEzShz/XBVMFyhx2XZtWMFQEOc6XQ/rL+3lLspwj+Ms/JUDtf+O988vOEdV+g1EPD2BNEBOH5zmWU8c2U92cyTKs2pwJOJ0KMaYXGoNSbG1xw9jUmVNqAdE193d1MRTA1OoBB8sOvAmJUr5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964998; c=relaxed/simple;
	bh=nJc8p2GNs8Jm6YRITnkhJNzeSRIo/EeYI8iIPi22W3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMmkpCnW6eEYpKikdUKIKoTa8EBQEb681R6xHvRb/vG2lpukd9l53nB//ABfw9BK+oO/Li8UnnMybJAJukOqSvPTTWDloSGEZwKax2AN/Wu73Z9GNKF5sbfb9I2YIab8G6C902c91IDWCJfgQ5hjBKWBnw9quLTWnGda/RQX+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGNXFG3q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGNXFG3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39C21F00A3A;
	Wed,  9 Sep 2026 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964996;
	bh=c1hwgXWxZ0ZvoTcNt6lGAe9EqL9kR6PwfvJHBh/+4Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dGNXFG3qh6sPrMF71B38Ur31/d2qagzKp354yvPFIioxM5g9vP/re9IKijSXNnj/8
	 LY+eV/yOJCQ+3bagFO7MyuAEzUw7r4Ij1cmFNYxs51Uc8Ez4HhH+pQyrlBhb0m9irO
	 18ZEwF6FRT1Kr/qSNu0K+xF0a5L94WU1Wz/motRW15xwNxQ63je9sfYNHd/458jS0W
	 GGcdk81pW2iriyQai1ZY6F+oYxDHjf9hr4Y5HxJ9WjYWIOUQICLlRfbEtA7Qp0M6US
	 0sj8rl7EDb0JJGGyhKmh1MgPe5+eLJ/EgX5xBG1bmvs+PtmEqf5uXZF+Ty6BtxXEup
	 EjRLYhS1Q/hIQ==
From: SJ Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH REPOST 0/5] mm/damon/vaddr: support {prep,apply}_probes
Date: Wed,  9 Sep 2026 07:43:09 -0700
Message-ID: <20260909144310.107006-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8f193651-9a6a-421b-91a7-df4a231786fd@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 9 Sep 2026 17:39:23 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
[...]
> I was under the impression that with the change, all possible operations would
> have a prep_probes handler. I just noticed that we also have fvaddr, where
> ctx->ops.prep_probes is NULL.
> 
> Ignore my comment :-)> 

No worry, thank you for reviewing this :)


Thanks,
SJ

[...]
