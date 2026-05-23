Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1553128D9;
	Sat, 23 May 2026 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779557368; cv=none; b=AY+iCIQHc8lUAhXiBTynMIUM0/y8JBR1u6HlGPNaqMo/n1l1b/7YQDerXzxrKgCkBaauHBL6sIMe1mM9m2kEmZkPS0lCuxCJO9WdqSZrxEh8F2v+f1QQKlK+96lzYY7H9nDRGShr48IfWox5zjC0Itaoo5KvbgO3vvT5wuqH+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779557368; c=relaxed/simple;
	bh=YTTxrgfvDskcava1zvmhx6HaBlAvmMItslTcvoh6mzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+Jerma9RBvUwAwGpsLlg8oPmCDCv/YeELBLj52d45lMHX24WXdt3WNJBLQlqk81sV070jYrGVe/+8DL9BGeCAw4eJzqqCPnzujzWB4UKE494QqsJnY41dJ6HnCb7MsFhg+Ylvh1OmC31pChe85mqzLeqveT0UzY3kHwJbhZBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTcJJqqz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTcJJqqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2984A1F000E9;
	Sat, 23 May 2026 17:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779557367;
	bh=dC7TBO9DtzsoaEzSvaAQuFc9cZ1hcuyyrjvxcLSBsWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PTcJJqqzQ1SKdxbrz+AfNbRfxYYbiVtztm5bXiQrjsFL79rMbwNgfwnNyWzP9qXV6
	 1hHnH8sQUsLSIrY05N3yd6r2AgeCfbP9uJ6fVHY2vH06S+S8VgX5//h+pif4YwgSsS
	 D2thfMu+8v7VFVHpg6TXuib7dW+wXD/mb6qF6J6sid8B1PtU4A/3zMEBvCw2zoUxv1
	 T081B5s8YYjaYh4faNOxw3V9au/RRp0wWmp744hAcC5hx9M6Aw/Fwcb6SzUhcg3j7P
	 jGowPcI5hJZKprtegItynRXFek7He1MMmHnACIo9CaIG2eSZbMJE3e9RmhCItuxZyT
	 zIij0czoL4MdA==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
Date: Sat, 23 May 2026 10:29:19 -0700
Message-ID: <20260523172920.89354-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522145518.158910-4-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 May 2026 14:55:17 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> This patch introduces a new DAMON module (DAMON_HUGEPAGE) which
> collapses hot regions into huge pages.
> 
> DAMON_HUGEPAGE operates in the virtual memory space, for a specific
> task. The user is expected to supply the PID of the task that is going
> to be monitored through the monitored_pid module variable.
> 
> DAMON_HUGEPAGE uses the hugepage auto-tune mechanism to increase or
> decrease the aggressiveness of page collapsing. User autotuning is
> also available for additional tuning aggressiveness control.
> 
> The module also includes changes to the DAMON compilation, so that the
> module can be enabled or disabled.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---
>  mm/damon/Kconfig          |   7 +
>  mm/damon/Makefile         |   1 +
>  mm/damon/hugepage.c (new) | 343 ++++++++++++++++++++++++++++++++++++++

If there is no clear use case of this module and this is only for a
demonstration, I'd suggest to make this as a simpler sample module.


Thanks,
SJ

[...]
