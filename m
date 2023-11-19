Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D359E540;
	Sun, 19 Nov 2023 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On2ZCsD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F73C433C7;
	Sun, 19 Nov 2023 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700415640;
	bh=uaV2tdwM0lkdg8Ayc3A5C8aWHQwdJPLoY2QOO1+tmtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=On2ZCsD0p3MFA0F3lusG1GUt2+TINnEot1/O36R2eWe2T9FMAR9B7IPOTSMCaNkY2
	 m2wbQEbNvJ5Q7sF0nIDRlBgc4WXxoqx9WxFQH6dPJhO8l8WZrxeJVmIaJSz1U/ZP3L
	 5Fl0OtYaaoV/Rp2ZsodTRpYI4O2JAaCrDIJDYsSJOSnrov5xky9W5Mg00EWCoXnblo
	 dT8QjontGUtneY9EeoFBh2j7tCTSPCIkoodGv5olSDNpqnLR/JF/aGb+945JznJFaU
	 9TGh3WL1dH1yE7WLF55/oocegRDlQ+7F6TFdY6A/Jp9C/f+jsP6/4GOoKzdMHXBHLT
	 wwljbK/QKQmmA==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 39/42] htmldocs: Documentation/admin-guide/mm/damon/usage.rst:124: WARNING: undefined label: sysfs_schemes_quota_goals (if the link has no caption the label must precede a section header)
Date: Sun, 19 Nov 2023 17:40:38 +0000
Message-Id: <20231119174038.78525-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202311152116.wp5LS1ON-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello robot,

On Wed, 15 Nov 2023 21:58:48 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   1c0004773dde317766d90f066adee4e2bc22a0d6
> commit: 520566dca2f1ac43c8782bb34f447ee3db88b931 [39/42] Docs/admin-guide/mm/damon/usage: update for quota goals
> reproduce: (https://download.01.org/0day-ci/archive/20231115/202311152116.wp5LS1ON-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311152116.wp5LS1ON-lkp@intel.com/

Thank you for this report!  I will squash below fix into the commit.

    --- a/Documentation/admin-guide/mm/damon/usage.rst
    +++ b/Documentation/admin-guide/mm/damon/usage.rst
    @@ -341,7 +341,7 @@ You can set the :ref:`prioritization weights
     in per-thousand unit by writing the values to the three files under the
     ``weights`` directory.
    
    -.. _sysfs_schemes_quota_goals
    +.. _sysfs_schemes_quota_goals:
    
     schemes/<N>/quotas/goals/
     -------------------------

> 
> All warnings (new ones prefixed by >>):
> 
> >> Documentation/admin-guide/mm/damon/usage.rst:124: WARNING: undefined label: sysfs_schemes_quota_goals (if the link has no caption the label must precede a section header)

Thanks,
SJ

[...]
