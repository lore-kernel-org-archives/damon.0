Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570936B067;
	Tue, 15 Sep 2026 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481677; cv=none; b=ddnJt1oVTu51YM4jVXDKe60mAQkAt5YP+Y0M0QbH+aF5h5gu/3Sf3qk74gza8/sgURQdkHR+OjIZpJPyANt8+GBkA4LmMe7kIdqvuCbKZIX+i3HxY6XcJdF09l/1qBM28EETIs6j5dkOTYmIeyqKlEO+erIAfMMqDRTU4aZTqWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481677; c=relaxed/simple;
	bh=zAw3VPAncfYUqgD/ih+a3+gXQAkKgmEW7+e+hZrzTKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqaAX2z45UQ1dzaYFldfY7yVf4ljS6KDle3mrPBrk5QIsudDcKYUajGLlxbYsIKT/zvIHPl3FPXGDL/dRVWDdx4UPYSnmH3OS+3yqgLkDYJ/fCAAFmvRY2D0i4ZZnUGBIFEn37/OyFomChuf6rkGORiHP6W0Ew+m7QEcWkHn+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1XacIHg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1XacIHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066991F000FF;
	Tue, 15 Sep 2026 14:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789481675;
	bh=sR5TpNLMyVHA+F15o9ghX8CSp2I4Iqafe8l+VrXMdfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b1XacIHgY4nUO4ZXqpEqIsG3oqFId0LiJ5rDdajHox/d32oNulnuUxuP3hC20covY
	 TxwGs+MfaZwZBIbsbCMWuV4256nQO217F/xGTPcK83F3Gc7n7wFb9YJ2vk4Qo6jxwq
	 xeHWkayxtyqgLJf7wN28M70PUKpJGhPIroCCSvcdqZV7bL1aCTsD4T+fWESkZr452P
	 VQIF0gITf1//tIHrDDjxOvIcwtnYOZgxIJi8pzOvakf7yl2ZadTj/6u/Z23k95Jl7i
	 N/D/D36xBPRFLOT2c1wremPaJKcfMDA7qmUV/tS3JK+AL3aXuRzfk+X+Vf1C/bf7VY
	 yPK/fzMVWMcbQ==
From: SJ Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 3/8] mm/damon/core: return an error from damos_commit_filter_arg()
Date: Tue, 15 Sep 2026 07:14:27 -0700
Message-ID: <20260915141428.90098-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915033050.1579457-1-kunwu.chan@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kunwu,

On Tue, 15 Sep 2026 11:30:49 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:

> On Sun, 13 Sep 2026 10:17:00 -0700 SJ Park <sj@kernel.org> wrote:
[...]
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thank you!

> 
> I'll take another look at the remaining patches.

A new version of this series is available at
https://lore.kernel.org/all/20260914142327.92510-1-sj@kernel.org/

It has no real difference to this version, but it would be better to review on
the latest version in my humble opinion.


Thanks,
SJ

[...]
