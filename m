Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82DA361654;
	Fri, 13 Feb 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770995954; cv=none; b=CamGc4CkATH8qFGMm+u5KYynSlvCEyPDhSh47+ZQLHiGW0Dx7Hy9l8x3IhzviabXR3rrL6yqB6YMqCdxkiNzuFoqOcUL5XUcbZKlIq+RNKwkfkKT6fEThQ42oNODERac7VQhpR6QPdZJhcFnPSIMt6fsfwO4j9X4BMbT7a8ovEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770995954; c=relaxed/simple;
	bh=tSn2VGHTk2dz7GxXDBVDU6D60bA8+I6ljFRm/Ed3mHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlfrel/aI7xWYmULv6dWFS4XMmFCMRXOdNcUbIsxjU7rzoZQpYU+eUGagslzh8gpHkMzLKc4HasDkmZMhYz3kcsLjk/LwY9A+u0ZvMsVqyk2q0roQyNPa5KTKs455isXTWXXLMEcBiEIP/vjDkSwnrYJqqWu3M0x/vpbtNDL+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvs9VpQk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvs9VpQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B07C116C6;
	Fri, 13 Feb 2026 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770995954;
	bh=tSn2VGHTk2dz7GxXDBVDU6D60bA8+I6ljFRm/Ed3mHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uvs9VpQk9HQQsZXXmwGM+CC8dkC4X+xDs8Pz9vfvJdx5044sHazl+H0wrYSbzQLs9
	 HxKsUKqCFESbgbX8GegXJnZ9DebdRKaisrrrdluvqAlM9Jb3hkNH1o1yNNPHLA1in/
	 RIRRDvyma/UGkjgWuC549amzjxFpC6S5qCCDZDCf2vMSduegS5DwRxEJ/M98d68kF+
	 Bh0g7QO8tGqXxju/l08Zxtdb9Y5iqqw/+bGEMVPQRCRckhfby7u8a8AXMMJ9IA+9cJ
	 UBmCF53qwAk1IQfLzYRhOik1WmEAa0DNt4nYRUBxpumykLiTNv/bjhtylNfyzanwRO
	 nVEOIRMhGRqZQ==
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
Subject: Re: [PATCH v2 1/1] mm/damon: remove unused target param of get_scheme_score()
Date: Fri, 13 Feb 2026 07:19:05 -0800
Message-ID: <20260213151906.74717-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213145032.1740407-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 13 Feb 2026 14:50:32 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> damon_target is not used by get_scheme_score operations,
> nor with virtual neither with physical addresses.
> 
> Changes in v2:
>  - Patch against mm-next

You mean mm-new ?

You should put changelogs under below '---' line [1].  Also, pleae consider
adding [2] link to the previous version if it is no big deal.  I understand the
previous version of this patch is at lore.kernel.org [3].

> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

I believe Andrew would move the above changelog under the below commentary
section when he adds this to mm-new.  So you don't need to do one more
revision.

Reviewed-by: SeongJae Park <sj@kernel.org>

Thank you for this patch :)

[1] https://docs.kernel.org/process/submitting-patches.html#commentary
[2] https://origin.kernel.org/doc/html/next/process/submitting-patches.html#commentary
[3] https://lore.kernel.org/20260212094326.906497-1-gutierrez.asier@huawei-partners.com


Thanks,
SJ

[...]
