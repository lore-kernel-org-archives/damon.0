Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677760;
	b=VdN9OG4qLoHDMEo4sS59QisVsD26TxMQOBfrA+Qriww1xVkfAw7ItnhSKizxT2ie3DVV
	 kRepCIMfrMncT7w61im0hZG7PjN7tSBphiWrTzaCCLiWSq0tFO3i02nOEF8gpIa4hW/tN
	 ZLTXoWHjje2zEa2OejZb8nSpItS+lJn+sCs3PJNzLIbRJAcPi/Jar218vjq/NaB+y1fPU
	 4m5JQrGPwSj6IQpVSCvCO+vscBZlSLmzibO0iw4kqtqQxykWJorFLX0DtHWNn5yaO/nAc
	 +ZmV5UOCQo5IdvyGWHDiX8kVtmmcctkUMmDr4J5TnN+30VOhCJkBTlwn3TSQxXUGuyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677760;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sbNemcwZ2jC1Uc7605k/VmRdjgt1QXoYjX9veU4w4sg=;
	b=gc8SruVPjndOIRZqAR+TI47BSQGFYiP9hVH6h550vLnIF2HTPcz6UtmD0Ncd58i6bzs1
	 JqhZTUPC+cH6pYrZadhyHmkMkL5lQFXjDyYYlbHsu7wd8SXIambEcJeIGbUToru6kMuPU
	 zYWhYYa0gFkFEsOSc46JJpHNFHtMFvJBZTI7ohx4g7UtBEh/4GTry3VtV+F0PAnnHu16Q
	 19IahklgPOa7ukU6MLDLQ0r811NjFwCvBdbCH5s1vesQqjs7jNXo4ZnbNrQNZUtMmNX6I
	 81+/jIQzSZL/08hLafoI8jUuEgoK20bmVCwnqATvSWG0Gpjq19MhNhA8XH8i/eDplIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmZMQS6I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC4D606A31A;
	Thu, 22 Oct 2026 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmZMQS6I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EB21F000C1;
	Thu, 22 Oct 2026 14:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792677759;
	bh=sbNemcwZ2jC1Uc7605k/VmRdjgt1QXoYjX9veU4w4sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AmZMQS6IkrbnfBT7rmh94KaapbRI+T4bPXW5CLrWD95W9hDFLpbSOXSkpw3xXQo/Q
	 JYxbCN3+IRkhfvwGbKgCVvGpsM9JFe3wWNJGlkRGMQA8ANaf9+k/k8xlBIbAcWnzPp
	 Gu/m6krdg/kpRdIkq5YulAXt+UH8IoI0/ZzjF63qWP73OIbZYob0g17timLVgd5BY9
	 qL1SDa2n9NHAzqyNmZU3icOaKvdcHz1y30fvMGOMzo/Hy1SlheQVwh6rxzfGOQ5vtU
	 IaQ5DJGIKcl9/aAKwhsqjbLGlEgU37FyaIqXZWnYggqAyaYAm21ybJnZiBUcAHUWfa
	 UUVl8+gih695A==
From: SJ Park <sj@kernel.org>
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sjpark@amazon.de>,
	Leonard Foerster <foersleo@amazon.de>,
	Shubhang Kaushik <shubhang@os.amperecomputing.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: align MMU notifier range when clearing PTE young bit
Date: Thu, 22 Oct 2026 07:02:31 -0700
Message-ID: <20261022140232.93962-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021-damon-align-pte-young-notifier-v1-1-d0365ac45b66@gentwo.org>
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

Hello Shubhang,

On Wed, 21 Oct 2026 23:36:19 -0700 "Shubhang Kaushik (Ampere)" <sh@gentwo.org> wrote:

> DAMON selects a byte-granular sampling address.  damon_ptep_mkold()
> clears the young bit of the PTE covering that address, but passes the
> unaligned range [addr, addr + PAGE_SIZE) to MMU notifiers.
> 
> For an unaligned address, that range extends into the following page.
> KVM ages every guest page intersecting the notifier range, so it can age
> a secondary mapping for the following page although DAMON cleared only
> the sampled page's primary PTE.
> 
> Align the address before both the primary PTE operation and the
> MMU notifier call so that they cover the same page.

Thank you for finding and fixing this!

> 
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")

I once thought if we need to Cc: stable@.  Because this is only for monitoring
accruacy improvement and DAMON is only beest-effort, I think we don't need to.

> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>

Reviewed-by: SJ Park <sj@kernel.org>

I applied  this patch to damon/next [1] tree.  We are now in the middle of the
merge window.  It may better to focus on making mm.git changes pulled into the
mainline, rather than adding more changes that are not really urgent.  I
understand this series is not really urgent.  Hence, Andrew might not add this
patch until next -rc1 release.  In the case, I will request adding this to
mm.git after next -rc1 release.  So, no action from your side is needed for
now.  Let me know if you think this is really urgent.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
