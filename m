Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C4FC1D;
	Sun, 20 Apr 2025 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745166431; cv=none; b=YuXbYO1VOps8q7VoSVGma8pBo9N0XerX8tF4qYfYkSi0PNMPTErDdEYGqd57qj1CONXnxtQxvz6WjloRib6CEGy9TWeUvdbENAcV5670ufYMAzbX6sOf/N1A7A/FjsnE8961pkiZwapdo0ll9Uc9KUtpai28TyMxSaR25mMr040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745166431; c=relaxed/simple;
	bh=l4DpvoZ2s+5NheW/iw+WP+lM6nk2Cg0No3jGiCAkkDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzrSt+/dGHEgbU5Yka4qF2/TFR4urysQnowVnrCbOlq7uUP4I/RBeXW394CfUHMRa0Py+v9Jjnml5M3A4Ed2UjRXBNVqQalW4X8Pbz6bsWtrkYtMchZPyCS+mEEiVZ1McDZ/FU5PBJ+S+2dKyN5SJ8DFGr40agrCNhRDYAQppcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIN0MxU0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIN0MxU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C66C4CEE2;
	Sun, 20 Apr 2025 16:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745166430;
	bh=l4DpvoZ2s+5NheW/iw+WP+lM6nk2Cg0No3jGiCAkkDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIN0MxU0MD6AGPjVyLyQJ4ASQeJaJREXdpOrdRw8DSfdWqpQVVkgbeWjtuhpLsLvo
	 CvbfAmbWkMHrKNbPRxUYkg8ooA32vNj0E8BAeT7W4u4IhfjWwPmzx9X/pZWdkCOEt+
	 y5fIrPDNHFtmwGLYSiim5LSoMIvuDV1PGAlTxgjrDfOYGgWs2XKYAx6xa/GCMKcZK3
	 MInfGQM8tyqDqNiabI+5zSAcg0gxbA2eJcMwiaQU0oHwhmQcHdcsJY8kXz45iqahlA
	 nPWZpnFBf3E3YGtjqHoE6vi8eAC3A7edVkVmva1hlGecf2DVN2OblNJZKDtzlyVrgT
	 ZIybJXV5Wk6yA==
From: SeongJae Park <sj@kernel.org>
To: zuoze <zuoze1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH] mm/damon: add full LPAE support for memory monitoring above 4GB
Date: Sun, 20 Apr 2025 09:27:06 -0700
Message-Id: <20250420162706.2844-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <5801dee7-0c22-4424-acb1-fe5f63645bc8@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Ze,

On Mon, 14 Apr 2025 09:21:55 +0800 zuoze <zuoze1@huawei.com> wrote:

> 
> 
> 在 2025/4/12 0:35, SeongJae Park 写道:
> > On Fri, 11 Apr 2025 14:30:40 +0800 zuoze <zuoze1@huawei.com> wrote:
> > 
> >> 在 2025/4/11 6:25, SeongJae Park 写道:
> > [...]
> >>> So I still don't anticipate big problems with my proposed approach.  But only
> >>> prototyping and testing would let us know more truth.  If you don't mind, I
> >>> will quickly write and share a prototype of my idea so that you could test.
> >>>
> >>
> >> Sounds good! Please share the prototype when ready - happy to test and
> >> help improve it.
> > 
> > Thanks, I will share the prototype as soon as be ready. I expect up to a few
> > weeks.
> > 
> 
> Got it! Excited to see the prototype. Let me know if you need anything
> in the meantime.

I posted the RFC patch series[1] a few days ago.  I also just implemented[2]
and pushed the support of it on DAMON user-space tool.  Please let me know if
you find any concern on those.

[1] https://lore.kernel.org/20250416042551.158131-1-sj@kernel.org
[2] https://github.com/damonitor/damo/commit/5848e3a516e3b10e62c4ad7ebf0e444d7be09f6b


Thanks,
SJ

[...]
