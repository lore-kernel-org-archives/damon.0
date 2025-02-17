Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CCE1A3BD8;
	Mon, 17 Feb 2025 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739831540; cv=none; b=k422EZeNUSPNSGEadLA4kDRvVzgp2tr6c3GRrYwFTH+bL+wSdNDuk/Jw9Ifvi8DOQX3cnToGc2f2dPttMY8YE2Lz4XtOJvXKIsgHM6IVAVrCqASa5zW6+bRjcT//UsKlyvzLtIwZw6u1Qy4qtpHiEha9QBXrc+GQJMOd7FygFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739831540; c=relaxed/simple;
	bh=qFKTkNpONgMg3NBCN3xgNv0kFxCr4BNqkB66XUagtOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YEe5tBQP7RVyC8EkyMm9OTMToYGYQJk/PJYUALiBXEVfFehGAa5WC2NQjkkyzb343/6ts4bdw5GDdDFIwVC5H7+v8lhCDUGnxEQz4FBhx9Y2Q6AFahCyneQ0BMtn/B77SwH1SwtGUsVFaRqWlYjFwT4zrVMnXAug3zzgAMMwXDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9nLc2mv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9nLc2mv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED494C4CED1;
	Mon, 17 Feb 2025 22:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739831539;
	bh=qFKTkNpONgMg3NBCN3xgNv0kFxCr4BNqkB66XUagtOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9nLc2mvL4bhKycMPuEB8L5O7B9VRy48+8XxJdGCVbGE1ebPUKKJbwWdZMLEIw176
	 Ar8ntIbx9QHcCdlwff9SXKalnWXHOqNpY+FdwHSeal83r+t0GvwCczyxMPI0DAe1GG
	 TFY0JqI5YK3O9m3K32ahSHDx5DcjKamwXZFLeTJQ+xId4Qep9kIkHf83n9VCatAanA
	 6D4eZzKK2mxhdimM07IXk4RsHJnHsZONkKv7ngzuLQXIQZ3cxtMU2IUH04ks72/IVU
	 yIK1LsaXe4v7p/Sx/cL9LBkMJJ2w3eurxg3jpwaW+g1sfv/d84Pv7vZUaVjlakHyIC
	 mmAJ1nmEAIMlw==
From: SeongJae Park <sj@kernel.org>
To: Marcelo Moreira <marcelomoreira1905@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] Docs/mm/damon: Fix spelling and grammar in monitoring_intervals_tuning_example.rst
Date: Mon, 17 Feb 2025 14:32:15 -0800
Message-Id: <20250217223215.36040-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250217215512.12833-1-marcelomoreira1905@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Feb 2025 18:54:31 -0300 Marcelo Moreira <marcelomoreira1905@gmail.com> wrote:

> This patch fixes some spelling and grammar mistakes in the documentation,
> improving the readability.
> 
> - multipled  -> multiplied
> - idential   -> identical
> - minuts     -> minutes
> - efficieny  -> efficiency

Nice catch!  Thank you for fixing these!

> 
> Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
