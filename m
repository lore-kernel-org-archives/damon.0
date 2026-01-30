Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233A2BEC52;
	Fri, 30 Jan 2026 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769737788; cv=none; b=ikrX+0Fx8uw3fzMvdh+Oq+/EuMVDl4BnLGmRkRc9+9isY4PDKMQdsaYvOmGvPl01DxyEV62IAeNSiQHGHiI9WSW1TFEpaqt//UvZfrHWXktIJFZPUgmOjezM5f6jvngLG/okqNt0nTTyUfOi5Fo3jUcvQ7/1jCHngFIEvkSrWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769737788; c=relaxed/simple;
	bh=+O3oU11p7vlRhXMV+aih4qEsfTLVMG95zNWLgADSuHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyDenbl2C2eVP9I+tdqjvZld9NNmIpxa1UERAr2qMf5VDAKzQg93Sw5wtUs9l6FzhDH82FPZMJQUil//z4Xua8kKvIVL6gU04jW5Km8UEPTTsJ0GUt5+aEKiK1d+TD102MeTPopMhLVKhsXTEY7+KtXj96JIuhNbHBNCJtjLKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkrIXiuG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkrIXiuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF0EC4CEF7;
	Fri, 30 Jan 2026 01:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769737788;
	bh=+O3oU11p7vlRhXMV+aih4qEsfTLVMG95zNWLgADSuHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PkrIXiuGbLxJG8ZqMHTviK6n2FyqIjagYGwqzQwgwlsRgH+04PztC6s0aU11TVb7I
	 B2qSHtwKzrpbdCKoeUGDZfmzxvQ2uXxqpY9FnuhGsdX65Ae9P2/dNmTPK77sh8xIdK
	 uo1ycSHc12fFbdPiYgFa8X+X8it8rPZUW5FBvxpAQme1x+L1l5ERAardjcj35bl1ak
	 6KZqqSVUPJeJlvyzFq0wHpj1SwuQUAUj0Gb+Q75XAvTHXz6QEyZj7zxIfUNXGBSYU6
	 EoBo+IwcLJxbZ/Lsf8mr8Ct3mkRH/QDAizUj3TYIJEB+8hsGEJhTXoaswpEa/27bEc
	 tJgtkS8Er4qYw==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [PATCH 1/3] mm/damon/core: add DAMOS_QUOTA_NODE_TARGET_MEM_BP metric
Date: Thu, 29 Jan 2026 17:49:44 -0800
Message-ID: <20260130014945.51416-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129215814.1618-2-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please keep "RFC" on the subject consistently.

As I mentioned on the cover letter, other parts including the design and
impelmentation of all patches look good to me.  Thank you for doing this.


Thanks,
SJ

[...]
