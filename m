Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7A3A1C9
	for <damon@lists.linux.dev>; Wed, 10 Dec 2025 02:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765335248; cv=none; b=Vl0bIsvRnuyyRuVzeypk2qEni9oPl/7dGNWdBxxHv35YNqfaZmMVjQZudLgjasuy/6IAXbWDBAENo7N2Lf7FPz+qT3t7awMTlQZbXljtxHdNFE5XFMH3wAmkLa8/Y6kIMYkBVTFr+BYf5i4jquGeJVnMC7nzDdYv99lWbfie5+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765335248; c=relaxed/simple;
	bh=spWxJyy4R94LZwBzdlJfetrxCR+ynZ+CcEoHHb7SaOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiWhVR+6CDeYmi3QBWB1s2YZ93BCfYahGV1rPdN+u+J7x3IoA/SKe5ur3CRXUDyH7pWm7/A3Stgh1OC8EfmzV+rBarYyKGtigzFAO98dc7tQAnJC1qEM032D0FSzAoBcVSHwTGAbRh388iwrbgFWWajaVx42rUXmmihILOgFd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZjOr8wZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZjOr8wZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A18AC4CEF5;
	Wed, 10 Dec 2025 02:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765335244;
	bh=spWxJyy4R94LZwBzdlJfetrxCR+ynZ+CcEoHHb7SaOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZjOr8wZRraf7SUQzi/1ZFnnoiw4O5ED4fQZlTaDRUWA2uT3f+VpoBUp9/Bf703CO
	 JW/u6h0Ic+DMRDiI6hTDxYKu1QQLXlTVF5F20G55mksRYD2iE2Fj9iM19DbODyrXin
	 Fkqd4Kc6gfItZ1OxQXdwns/vh8l6G15A6maowQ0w03DaeKi6tlK9jywpqiOedl3CAi
	 bb5r8TcMMqmUeaT606EU+MqCKZ159oDW1rgh37w49XA3ax35r4HjJyAVvFXccl6dIx
	 pho4HXaq85lEiLBL5qX+/VU0qeLK2bm3a19+hVFP5Kdy4FC3VUjg3ETwNQMd7DxoSE
	 5vUJ4qzGyLGRg==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: modified damon_call_control from static to kmalloc
Date: Tue,  9 Dec 2025 18:54:00 -0800
Message-ID: <20251210025400.51467-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC6_-h1jQkZMbtYDC_jrB490jzp1t1Fx-_mhYnE7tqvzbw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 9 Dec 2025 21:20:42 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> Hello, SeongJae,
> 
> Thank you for your detailed feedback.
> My patch has the advantage of removing the use of
> the damon_call_control.dealloc_on_cancel variable.

Thank you for keeping this conversation for enlightening me, Jaejoon.

Could you please elaborate why you think the removal is an advantage?  I
understand reducing code is good in general.  But that's only if the code is
unnecessary.  dealloc_on_cancel is there for real use case, so I don't clearly
see why it is an advantage.

Meanwhile I find the feature might look complicated, or not well documented.
Specifically, dealloc_on_cancel should be set on only dynamic-allocated
damon_call_control object, but that is not well documented on the kernel-doc
comments.  Are you saying removing it is an advantage because it makes reading
code easier?  If that's the case, how about improving the documentation?

Btw, please consider not doing "top posting" [1].

[1] https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying


Thanks,
SJ

[...]
