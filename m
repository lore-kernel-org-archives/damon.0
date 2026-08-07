Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17C47D922
	for <damon@lists.linux.dev>; Fri,  7 Aug 2026 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110791; cv=none; b=hFGs9LfeAnFkcdB2TVYoUra4oI3tKIJyCrmh43lqfC+FTPHxZTv/iykz6LGtL3AeEifcZAEG1UOIMQhudUmG81VpPsL4NEypZlx11qRLTVwaZnfCIfF3qktvMVNQXDCInWJ9cRLJIJ+hNu5advV6M03IjS5zAnsXGNP2C6cVn3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110791; c=relaxed/simple;
	bh=mLBs6EROa7ZtcUd+WFiB41ioUpM2TQ7qBh0hCXwB/EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCbTCq+5FS5HPMrJTYEYvOv5mmcBDw1jFmYtDEUSytpqUDG0jh7CJzRuuTUsEWwTkmsI/rN0DXFzNQqkdOkWQUuJifbd09a1R6Xpk9mOaO0FClneGiO+AjPY5XlTgmx9ZjferXOysXXwiC6U9xFMgHcQxVac8K3GeNDRNts2h9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gfo2pa8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gfo2pa8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D3B1F00A3A;
	Fri,  7 Aug 2026 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786110782;
	bh=XLmyX6PhcnTmivWl7rzGTTmoWyX2vh+vVEFc0xm/UwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gfo2pa8w60elepfN5stHdRVpJBos0YvI06jFft3nWQ3FRYfUPIf01zi5XHnm7tuTo
	 Zkggd8O9/GqLMrLkqCGVE5ptWcyNvt9iND1i6UMl7cmkwJkzXlBCR9dBAjKpwwlequ
	 Jyp+PPdKWaLPMZ/uCeyQNHKZianlSin6XLg9yol/feRbqS5yWlWcFVIW/SbeLFTtVk
	 IxM6FXjKhVBzsy2dWOB+CtuAqztbmgEt7tgZaVg/IdQ1PwinLLU3bK75p2GicYjdss
	 F8Y4QTLXb28Kr6Ht0ns6mpW8s2WCVPO7Pk2ibAFFHPgUque91WBVz2/fIKnf9R8pzR
	 BSJ3zbMURObRg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/damon: fix nr_snapshots counting using tried_applied flag
Date: Fri,  7 Aug 2026 06:52:59 -0700
Message-ID: <20260807135300.90965-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260807093526.183009-2-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  7 Aug 2026 17:35:25 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Currently, nr_snapshots is only incremented when damon_is_last_region()
> returns true. This is semantically incorrect because nr_snapshots should
> count the number of DAMON snapshots (aggregation intervals) where the
> scheme was tried to be applied, as documented in design.rst.

I don't think the current implementation is wrong.  Maybe the documentation is
better to be updated to "...that the scheme has __completely__ tried".  Let me
know if I'm missing something, or this implementaion has some practical
problems.


Thanks,
SJ

[...]
