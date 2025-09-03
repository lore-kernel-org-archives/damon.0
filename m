Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1FA32F76C;
	Wed,  3 Sep 2025 01:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756863987; cv=none; b=pd5OuUdLXxo0DQ9LXXYYqju2uxylEOOo3FMwDx8o2rH/y/d41tiuZH0BLDrTQnn3DuDLuNBoS47KrhshnTGos7zrNc6yFFxDftX1rQBn16YyJnmq4AZnKkOZHurve97ELMh4F6tVP766W6Fp+7SI47Q1/SOfjr7r7WFkN9vR7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756863987; c=relaxed/simple;
	bh=JYQJXQLUTtCdpde9q0/RxOgq+1jnVlaTqJgsOOHQBu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sop1Xv242wTUl7s8Fu9KwXhuisd5Gd6gkZ2bKMJpvZrxfDFAJBetxqjjee1dJEiQxUvno4HeSu13K/7bt74IxO9uTenQQpvqpSRdRPncncp+aQI1cKXFqcqVk2rW/TynWkvl0QeI7ZF50qr926w1zTLEUwyCpDJcZQFsT/6Or58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3fM9qnO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3fM9qnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3E5C4CEF5;
	Wed,  3 Sep 2025 01:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756863986;
	bh=JYQJXQLUTtCdpde9q0/RxOgq+1jnVlaTqJgsOOHQBu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3fM9qnOx8x8rqaxU3+VbhAG5zOd3MJ7sLOdH7Jv0AE1m+fSYf22Y1uXBx6+8gb3O
	 TaaeavLqfzghk8bOUlU6FPG4ToH/reAQB89E8AmZdNaNGqa90HZLIgKW7Z5iTZLXnu
	 KU9VNaAfOXZys1UdDc4893uaLALHyIryypWB3DqR+OTKDry4KnJbD2Z1gxGgMqHlxx
	 oq3jrRuV50dEGJBGdVYD099fedVrxbHVmgmGH0NcXUGCh8PHMGAup1cXKECgRbmfg9
	 T/7S1hn9m5SvKxrTEuin7l99hEY1ULOt6VAWdq34ZpumiFBzzLk+FD0nNPEOz+GmKd
	 6o8OaXqe2x5eg==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 109/109] include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 16 has type 'int'
Date: Tue,  2 Sep 2025 18:46:22 -0700
Message-Id: <20250903014622.191177-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202509030638.L4D1o07A-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 3 Sep 2025 06:37:10 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   b40ae505a5ff6123396b42b79f42ad45df461634
> commit: b40ae505a5ff6123396b42b79f42ad45df461634 [109/109] mm/show_mem: temporal build fix
> config: i386-buildonly-randconfig-001-20250903 (https://download.01.org/0day-ci/archive/20250903/202509030638.L4D1o07A-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509030638.L4D1o07A-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509030638.L4D1o07A-lkp@intel.com/

Thank you for this report!  I just fixed and pushed it:
https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?h=damon/next&id=a1930cb685dc358b39f92dd008f8ac1430c2aeb5


Thanks,
SJ

[...]
