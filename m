Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2639822F76F;
	Mon,  6 Oct 2025 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771123; cv=none; b=KgwdWcWeWtKImgmWIBMHjP8LM/sCrZ8iWw32Md1sOJr4w1biJNMAdCeqfgtCUPZPO6byWYbvg9rxJvgZBnGiWK7Ww5KBCz/kD94NvoEqEcRpR5MRdpxrvy+zou9WdtMfe4z8Q/yyuBg38ro3jwrXNfgazGRxSzJMdFMbPpkkaEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771123; c=relaxed/simple;
	bh=SfxMdBU6y0tqa4mF6l4hXNxeVEuJfM5uMhZ8hI4CbCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OCXajY46iINT4FMpFJvNYMn79E29Sn9LBMY+fn6SE48r/bLCmLlmJmyj7CKYoru5WXLsFrQ1ztg8ZMAlqn605pgtCKp3/r1tXXFbdhkm4VhKqBCRMnzRcqlS/TCiRxs4kg4e5crI/ynpbFDFB/o9uEV8EcHJNqPu7PWJB8csOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fiejpe10; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fiejpe10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E00FC4CEF5;
	Mon,  6 Oct 2025 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759771122;
	bh=SfxMdBU6y0tqa4mF6l4hXNxeVEuJfM5uMhZ8hI4CbCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fiejpe10UbBJjarXtt6tSJk0J6IvEZTsNnc1DEqoWg0+eJ1AQ4zx2mx3EBwH0mnu4
	 lmBxWg41qt/BPvziRJWL1VS46TXiDmYa/rhbUOTUObRSfFxXAShWL4Lq1YIPJBYJmH
	 fIRTRllkIOCs0BKoP+KfHgD6KgFOk67QBV8V9KZLtDc32TPRi3UZRaeZjhs/2DNSLY
	 Gc0D7ZjJZowkjAcZ2ayvZciCsE8IpLNrqDncDYU+GxtwxSLsajJ4GoFQKwUkV39lN/
	 yRwrLX+Tu8QcctxAyNzaDBZXVO5rUzalSV4h/oEhDDo/jnj/fLQ4b5vmK8eAQBuA9R
	 dWukQW+kcxCPQ==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 120/121] htmldocs: Documentation/admin-guide/mm/damon/stat.rst:13: WARNING: malformed hyperlink target. [docutils]
Date: Mon,  6 Oct 2025 10:18:40 -0700
Message-Id: <20251006171840.91462-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202510060124.YaUaLfkH-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 6 Oct 2025 01:45:41 +0200 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   d2a846a38c8b6e1f2473db076998642ea3bac918
> commit: 94d350c7971494ad1967e5d04745401a08adbd83 [120/121] Docs/admin-guide/mm/damon/stat: document aggr_interval_us parameter
> reproduce: (https://download.01.org/0day-ci/archive/20251006/202510060124.YaUaLfkH-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510060124.YaUaLfkH-lkp@intel.com/

Thank you for reporting this!  I just pushed a fix to my tree:
https://git.kernel.org/sj/c/347be1d4cfca4617b44ae692cc67d7903953c542


Thanks,
SJ

[...]
