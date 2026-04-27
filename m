Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D6A26C38C;
	Mon, 27 Apr 2026 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333278; cv=none; b=lfp1wZb33MsR3cL/hh7/XD8DehfIDQBrG+cymAUpw0FnE/NAiYjWoZvySEWjYBMoF3GfcRYBZLBUX3ULHlkQRoVoZ0Ta4dApeE8l1++0nDTo8bZQJXO/ghinDPvf9wIUY55wKBmh8sTX3iKBySWbbmXTL6mX4MouJtkWGlO+TDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333278; c=relaxed/simple;
	bh=j3eKjY8PPbVBXWxEaIlKvaUtDpsq77HAbJa5qEyE5Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTxCwEM/PLImcJueh7Sjq2gnZYhKpqdnJMaY1Fr7JdnQdcqZ+P0upzYj/tjpJvXNbQcj03jF3Xz3d0a4K6uG74aigLXa1dG4R0kDJgibr29AjxthRMrE04GmtwESAaxbbojUvuhXDScoHd520MQFBcVa+Bq02QZclGFsOv9SuZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzjLCjcU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzjLCjcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF35C19425;
	Mon, 27 Apr 2026 23:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777333277;
	bh=j3eKjY8PPbVBXWxEaIlKvaUtDpsq77HAbJa5qEyE5Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YzjLCjcURhfZe0BV5T9KU2DvNDTKg4XYXnNshRfqh3jFPqC1uRK8HQJezCNJd/Ifp
	 pxHQP0JaSRLm5pHQ4PfZwpY0UpRtZ3u9aVpPl/Y/WHeLyUl9I2BnVt3uSqRpiSAeif
	 pkZxeVJrhlgdAVklYA2LB3BhTEOTxuKDmupQDJ5xJFVgoHDVaTKSZSH2XVWIUMRitm
	 QwhW7yo+BcSmYQDntRDqaV9cZNS/8xkNqY6DfWemilTxfp1PPRZ+CdCoSVsajbxz9n
	 BTMjc0VJ6a5TB/fMD+dhd/a9ZkTaUDWlLXRAt2cfR8sjvx1eAcVzzI4Sigy908E9EW
	 i9kTXupYN/kEQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 4/4] mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
Date: Mon, 27 Apr 2026 16:41:14 -0700
Message-ID: <20260427234115.154563-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426231619.107231-5-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 26 Apr 2026 16:16:17 -0700 SeongJae Park <sj@kernel.org> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> This patch set introces a new action:  DAMOS_COLLAPSE.
[...]
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

I forgot adding my Reviewed-by: tag here.

Reviewed-by: SeongJae Park <sj@kernel.org>

Andrew, could you please add the above Reviewed-by: for me?


Thanks,
SJ

[...]
