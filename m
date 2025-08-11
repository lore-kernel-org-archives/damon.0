Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFBA296BB3;
	Mon, 11 Aug 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930108; cv=none; b=kV0oDP+JKEIi/Sp9LuND8HT+Wf1WxtwJNTGQMeYjpQnNhP48Y3ou8cPTlxGRcbilxA4QNPG5zgYhIgBuouUW62g9o6GxBwFq/mlM4LdNxGMbRkSyzelebHLGbZIrvTvHcRtwBcAhFTZ0VU8AIQ6NoWs9KGzZiXCLSOrEGhLvDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930108; c=relaxed/simple;
	bh=U3ajoq2JrlMt/JwLVtLkb6ZXEGfnsVViHIOqNoUf92Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DFRoksaLhoKBcDDb1dixIflrCZct0rQIRXdwyFLwTyeQUOwVjKq3bDRyE8ZfZcXDlQbvDQxEUFgvQRmI6NQqVql8JV7lZ5qsQYG9BJRqwuRdVzWBEkH7BjQyk6NCXmjG46641q6L0FOEXaBcgzOF/u8iFCtSV8IZlDxK0anqe7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsEskb/x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsEskb/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D41AC4CEED;
	Mon, 11 Aug 2025 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754930107;
	bh=U3ajoq2JrlMt/JwLVtLkb6ZXEGfnsVViHIOqNoUf92Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qsEskb/xJAz3GxhKxE0sBOWRebcAIO53TMFP/Yn85IgldEGEVADeuMoXhjJiPSAB4
	 ye5JPikwIET8n/WchW2Q8XAS5bdZN9ld4i6Y0Le46v7rWK+6APLIudA9Sv93N5dVWf
	 55SHBcT9dVIRHsY1cx3FeXqF0fW+co2jmNu05J+V15mH3U6Qypk02fS1K894eSmBEq
	 jaswoGPazb0RApM38bHVXjxBnHLr/ZB+2iYyI9eR0o0vEQpgac3OxRMagD2rMzWWqp
	 NFJcaa86W4/7B/UQ7Nsp0VkiDKE0RIvn+4jLQ4nyqs05v9lZNeiVZsa5SjIfzFqP6W
	 yz4kiyxBk+YBA==
From: SeongJae Park <sj@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild@lists.linux.dev,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH 2/5] mm/damon/sysfs: Implement a command to only commit scheme dests
Date: Mon, 11 Aug 2025 09:35:05 -0700
Message-Id: <20250811163505.62056-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202508101330.XRQqvfiN-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2025 10:00:50 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hi Bijan,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Bijan-Tabatabai/mm-damon-core-Add-damos_destroy_dests/20250806-120845
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20250805162022.4920-3-bijan311%40gmail.com
> patch subject: [PATCH 2/5] mm/damon/sysfs: Implement a command to only commit scheme dests
> config: microblaze-randconfig-r072-20250810 (https://download.01.org/0day-ci/archive/20250810/202508101330.XRQqvfiN-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 8.5.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202508101330.XRQqvfiN-lkp@intel.com/
> 
> smatch warnings:
> mm/damon/sysfs-schemes.c:2605 damos_sysfs_set_schemes_dests() warn: iterator 'i' not incremented

Thank you for this report.  Nonetheless, this patch has replaced with another
one[1].  Hence, we have no plan to make this patch be merged into the mainline,
and we have no action item for this report.  Please let me know if I'm missing
something.

[1] https://lore.kernel.org/20250806234254.10572-1-bijan311@gmail.com


Thanks,
SJ

[...]
