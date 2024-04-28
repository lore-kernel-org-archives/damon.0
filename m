Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B18D74407
	for <damon@lists.linux.dev>; Sun, 28 Apr 2024 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714332984; cv=none; b=TaZ1xmNssCJNhZBAcID4KbByZpnBDwwc76qjj/3CeZ54XMsWvQNS1gl1E+6iDtWu0Ag/pGIdG6g23nI9YArm4nJKOalL+m9Crm3s5gVdA8uCp47HKlcPH9a+TdTXmUWtYUfWpFIUIrFfbYyPzkKT7T/Ua1aQvz7FJOA+/becZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714332984; c=relaxed/simple;
	bh=ABEfOmLcf1ftGDsVZv49Fkz3a6SXVYqVal7ixHKCNYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=acxHuzltrWniaj4EJIm/HivO8pE5Q3MtjqeQciLM6ragkkufBMRuPUlV4ivnGaXxGo3kzgM5J/PwNC5YTR1WogIuSubjPH2nJ4zM8F5mM1cnFuiROI1Ejt9LbRiPTKmHEXTfr4PlefTYPYY1N8eyBTotzDdjufBG6XNpuEPTG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkqSLDYH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkqSLDYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCB7C113CC;
	Sun, 28 Apr 2024 19:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714332983;
	bh=ABEfOmLcf1ftGDsVZv49Fkz3a6SXVYqVal7ixHKCNYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkqSLDYHg0QGGm4EOPZyAWR01/g6LC1r1HPxSYlrWHfg8QvzgzXl6eB8/1GW5QM7O
	 1uupKPQDBRbeaM24lq01i76YR/CsoXLnVfBE2rH1urU19jMhRvYsqEEguP/XAxqW9b
	 hqBQmaHuMdBS5XXm9uG0Vu/lt92ct0x/XANoovbH/NHLofycaWCYYKOufeOYpK6g71
	 c5Ohfn/81XcHI/2HtbV4/1Y1+PZs6mjovgSfczGlSyBw1pJKmAkUrWJc5Ob2MNaw30
	 e+YohTMn2rLDOBsqqG6z8Ri2kn8iuIeegGZwu+Wascyu078z78EoPplTQx3SqhuJU/
	 wCn8aBKl1EPmQ==
From: SeongJae Park <sj@kernel.org>
To: Alex Rusuf <yorha.op@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2] mm/damon/core: Fix return value from damos_wmark_metric_value
Date: Sun, 28 Apr 2024 12:36:22 -0700
Message-Id: <20240428193622.92923-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <d14a5a00-782f-48c7-a3a8-2b62846d29a6@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alex,

On Sun, 28 Apr 2024 22:17:26 +0300 Alex Rusuf <yorha.op@gmail.com> wrote:

> SJ,
> 
> thank you again for your comments, I'm not very familiar with sending 
> patches here, so I'll try my best, thank you again!

No problem at all.  Nobody is familiar with the process from the beginning, and
you're doing great.  I'm happy to help you. :)

I'll also try my best for making the process easier.


Thanks,
SJ

> 
> BR,
> 
> Alex
