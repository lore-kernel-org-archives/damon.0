Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D25126C03;
	Tue, 21 Apr 2026 23:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776815262; cv=none; b=m8WXDv0YM773fUu8xcsN357Qm6q4+yzvGUdaV4WRX1+7+ID4JpmDB9jOm83RwRSjj6i4RnbnBeKibx/uYs9MFx/ToLxXaDkNwGJAnuQLAuxxCdQHCiRUCUFuIhAPQDiuSY9yYUy4XL3DhVSeoexCLyJslAzdPRDNyYMCnFk9QcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776815262; c=relaxed/simple;
	bh=n8P7NAk4MfaX52F6FocZC+IRnLWA3imvHKLgX6nXRSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFYEKv2Zvt6gCi6gJ0zb1shUdQft8HCLWv5rJzaJ38YBYJmoTh7E0nYJdNYgg3KBNbiPbJJX+cw2vgXyYX1fA2sgGnXDyXMED+h7H94ghpeK043Sq/Msp9oC2aeeZaQGRmGBMcDRXle69ltrXvQnEekiMxdq8uWLQqQkrswsBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoUmy2Rm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoUmy2Rm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A570C2BCB0;
	Tue, 21 Apr 2026 23:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776815261;
	bh=n8P7NAk4MfaX52F6FocZC+IRnLWA3imvHKLgX6nXRSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CoUmy2Rma6WejeMfLEwtc4PhzThuA/zydQvI9wcl51SkM0u4/qsFlzBi6r5FZ5qcF
	 GyQky8AeSNCLeDlpesEmoTSgEF/rTZwuBEoFcsxCY5+eXfAn+5Zv4Q6w72Rk546ous
	 +W0MEGCvVdNRtDDD9NP1LnrLwBUXQPQVBaLCpzju5656M/UH6DWk3HrflRhcarXBDE
	 0c+lZcqqqlj8LO53sZ05QK3+iuepD7BOrSqE+JXxHtpcIT3S2fg8XYSkgNfIBN3OTK
	 Q0icmdizVUcH2b5VsCStw5c9X3K3ruM7+BBzybMF5OVBVdrr7Zu1QFXd6EcZNDUs6R
	 sDI4F7m+YqZIA==
From: SeongJae Park <sj@kernel.org>
To: Junxi Qian <qjx1298677004@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: fix use-after-free on memcg_path and goal path
Date: Tue, 21 Apr 2026 16:47:30 -0700
Message-ID: <20260421234730.2917-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421070632.161808-1-qjx1298677004@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Apr 2026 15:06:32 +0800 Junxi Qian <qjx1298677004@gmail.com> wrote:

> Hi SJ,
> 
> Thanks for the suggestion.
> 
> I checked the show/store race further and was able to reproduce the
> memcg_path_show() side issue on a KASAN kernel.

Thank you for sharing this, Jinxi!

[...]
> I will spend some time thinking about how to fix this properly.
> 
> If someone more familiar with this code would like to work on the fix
> directly, that would be greatly appreciated, as I am not very familiar
> with this part of the code yet.

I think you could protect the memcg_path and path load/store() parts with the
damon_sysfs_lock, but using mutex_trylock() instead of mutex_lock(), as I
suggested.  If you prefer me to finish the remaining work, please feel free to
let me know.  If that's the case, I will work on the fix while adding
Co-developed-by: and Signed-off-by: tags of you on the fix, if you don't mind.


Thanks,
SJ

[...]
