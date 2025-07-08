Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E422F509;
	Tue,  8 Jul 2025 00:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933381; cv=none; b=MJSZZLULokCFdPKrAOE2/uTfSaY0pTNM3G6a9Pj/p66mD6wcOTjcYO2WZhSYZSS3P4G62Zc7SW89C5np7fJ9NsQSsxxtnWaCHzsrL/d/g3voGl1aeHxf61D4VOQUwFkXRjioeSu7ewYMd1ZaKrF4s84f+NECgokgQZJ+qZo/hY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933381; c=relaxed/simple;
	bh=3Eenr3tBt0LMjc0TxOmqF6tmk5oFEwp2fIeGdqb/fRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfBQMfQU196D5aww/H7JWkybubFTU/Vzr5TnTjYCBcbRHZ7V52waqJmapzE8TiHRkLH7uKXjZBRIFgyIGrqgPxiv5WVFwbr4aYlsypEPUqcJKJ31tcDQezbiiRWHDTTqLe303WqEFOclV7KDnFyH7kWZItCIPESAAFubuKIm+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF0c7sIh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF0c7sIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6810AC4CEE3;
	Tue,  8 Jul 2025 00:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751933380;
	bh=3Eenr3tBt0LMjc0TxOmqF6tmk5oFEwp2fIeGdqb/fRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bF0c7sIhxOGVZMmrh/MjGShyboZn2Smee74s6+kUFXNS4+EaBdcpmiobLR6aoJDnO
	 tdEy8CZ08UJFzRoa1aHqLH07W8JsAnJDeY3jcbx34p2YAzrQPUaN9yDIdmFPK4uxHR
	 jPki6dtfD5TY/tYXOkJ3RBImQ6qgFX17Z5gjovktfoiAwVFMppaMRq7AiQjYSLjuHr
	 /p7SDNlsQQw4YJ8sea+OV2QOi/LXI3OC6rrNLp5/hO7bGb2Vb4S5V9Zyk83zQzheHg
	 exgniYSAbUrIq2xtWDdoa3Xt3mfwlNFoYvo3uJyyl1Lw9RXuuUmmrJqgluDq9jbzr2
	 VLWJ0qaWZ6lbQ==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: Re: [PATCH v4] samples/damon: support automatic node address detection
Date: Mon,  7 Jul 2025 17:09:38 -0700
Message-Id: <20250708000938.91516-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250707235919.513-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Yunjeong,

On Tue,  8 Jul 2025 08:59:18 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> This patch adds a new knob `detect_node_addresses`, which determines
> whether the physical address range is set manually using the existing
> knobs or automatically by the mtier module. When `detect_node_addresses`
> set to 'Y', mtier automatically converts node0 and node1 to their
> physical addresses. If set to 'N', it uses the existing
> 'node#_start_addr' and 'node#_end_addr' to define regions as before.

Thank you for sending this patch :)
> 
> Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
