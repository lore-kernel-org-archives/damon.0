Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06719265608;
	Tue, 11 Feb 2025 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306932; cv=none; b=YL8AywQE1b3NoZEqHqvG9d8x8V8y9jKqwItBhahMOQrE0FaTd366Zi1nNkSwvBYgTBkWeFQHfFbAEkFKIW3bVonAOzZPOXMjyOGnaXB2ZZfPeQ0kCR7R17hAJmbzhxzDgf1V2CzyPNVtiXS+6K5KNHvXV8TN31UrpcHMSOBxMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306932; c=relaxed/simple;
	bh=Y9Wjbv7i05qi/Jmy83+M+upT0I2koCoE8smbuZ3a1Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QoM/e1Xx4D09y7vdFE+IR1V9AuE33yKhZ4M0GBlVSbBPQiHKiXoBjH82lm2jSalL8p8TYg0TaWHNcYawIH23tl2MdoBIo/rAMjGKI2oIvt3dObn2o1vr3IMRwWAjE7vo8oSnJ/ElFUOeW4WUoMUuv0w/RriENO2Hy7vq711TXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR5Frp6O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR5Frp6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544B0C4CEDD;
	Tue, 11 Feb 2025 20:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739306931;
	bh=Y9Wjbv7i05qi/Jmy83+M+upT0I2koCoE8smbuZ3a1Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bR5Frp6OVV/VylmLrk15xC4n5aIKhHk4d5GlkYoljC/FbdnnWEpBhpY7uOW66HiVQ
	 HgQwrCzzcOOLvKcxH2DAhGAGTSH/vFwxr7AJ7djHRgmK3hdOg/54dqVlETPX2TwUj0
	 WQ3R854+kM90nZgzAX26W6+nC01CGkG3Yd2zTUYbEHJcxlISAlIZHgcYLLdERxjs2f
	 4ErSbB1ylpqiT2t/vgKVEQq/+TqrC3TIIbhgFCRLNIlxUOkX4JZ9QBUVx2Oh6Dabs3
	 nFzmgAyofSlrq9AfHmukiPnXhEvXoG4oR4Llnew/09KVtoBz0iCsvwSqfybqNkvlq4
	 wh5iwxWD16mig==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 13/17] mm/page_idle: handle device-exclusive entries correctly in page_idle_clear_pte_refs_one()
Date: Tue, 11 Feb 2025 12:48:47 -0800
Message-Id: <20250211204847.107933-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210193801.781278-14-david@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Feb 2025 20:37:55 +0100 David Hildenbrand <david@redhat.com> wrote:

> Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
> we can return with a device-exclusive entry from page_vma_mapped_walk().
> 
> page_idle_clear_pte_refs_one() is not prepared for that, so let's
> teach it what to do with these PFN swap PTEs. Note that device-private
> entries are so far not applicable on that path, as page_idle_get_folio()
> filters out non-lru folios.
> 
> Should we just skip PFN swap PTEs completely? Possible, but it seems
> straight forward to just handle them correctly.
> 
> Note that we could currently only run into this case with
> device-exclusive entries on THPs. We still adjust the mapcount on
> conversion to device-exclusive; this makes the rmap walk
> abort early for small folios, because we'll always have
> !folio_mapped() with a single device-exclusive entry. We'll adjust the
> mapcount logic once all page_vma_mapped_walk() users can properly
> handle device-exclusive entries.
> 
> Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
