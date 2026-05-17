Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A23112C0;
	Sun, 17 May 2026 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779061945; cv=none; b=inc9kb3/q9pJxCnWljr00sB6Q8O67BW87rjs6E89llouA4b0B2jxY37s50G+2dbm1OZN4x2T1wSTZaLC5zQbx0nuZ1r/HzrWWQEjLQ8e986sO30gfORiGOavLEGszEmr/z2tOTcif6CSuO0n7ZJKSBuzexdYdpcG9pZqFAiyi20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779061945; c=relaxed/simple;
	bh=l9YnwmGFtVsO7WOpwLzCd3C3mM7ny6syTlIW4Ak+ykw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCJrFEoE3DNQ493n6aeX+ClWDCM7ZAC2YBYX2O7tlKn8Z23t4HAeWR1h1ugAZRaQAg3wj32WjFZVAp1K+/R7h4RBH1Dj24tkOOwrFoHhsbkNu5CoQEZinQsQZShLE0kuS7l9Z81+MZkCl6GbeDyqiQ8GJZwFVvOze4B17fFQZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpGxhJ8P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpGxhJ8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68247C2BCB0;
	Sun, 17 May 2026 23:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779061945;
	bh=l9YnwmGFtVsO7WOpwLzCd3C3mM7ny6syTlIW4Ak+ykw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EpGxhJ8PZ1mrZaWrDJXh6WWy2VPAoyvkCKryB5M1fTS99t/Pks+I2HzC2cjBlvMf+
	 IFJzzPUQJ4yOx2kRG1yXWa7TrEnQei8CnKBwFEXduc27937DyP2+fiB4kgSpUMpKig
	 zb4Rn0M8cHdTcNgjut3MAAw4sKYBJvfdXHzhEpn48+5knuJAQ5r8xuf9JIJEll6G29
	 cDSqAjE9kuFX5QXAQJXU0J0gFR32f8Gu5wcUOCp9+3vRrlKXcneVlEacUlNMUe4dYU
	 4FSWLB9i3pp7UszehCOX04rMN3f4ljmIDLe+vXLL3CsfVkcXp6nO3EAeF1Z0Lf4Ic4
	 aMVfpvaYUlPqA==
From: SeongJae Park <sj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] Docs/{ABI,admin-guide}/damon: fix various typoes
Date: Sun, 17 May 2026 16:52:13 -0700
Message-ID: <20260517235214.89662-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260517182624.7167-1-zenghui.yu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 May 2026 02:26:22 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:

> ``damon_target_idx`` was wrongly written as ``target_idx`` in the docs. Fix
> it all over the place, as well as the wrong directory count, grammar, etc.

Nice, thank you Zenghui!

> 
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
