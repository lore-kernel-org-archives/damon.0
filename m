Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE3B3B19B1;
	Mon, 27 Apr 2026 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333172; cv=none; b=Z5MKyjrSmAsfbDoadqiAbB/22/sbfNr0Z2AnkgmoPENEa7nlc8OYJITigHIJ900Mlp7wZDWG31Z+6VmDSk/s440YH/QhUImrIQ/lUvw1WjmmwaZMtYGoTMweJSEZ/cSD8sEPumQTR7e/l41OJi/kaeS/b+PPBJBOlKF/NhP5MoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333172; c=relaxed/simple;
	bh=Zl4RMPcd3Mruw3bjUpCvED7vUUWsDSlxRDKdrEHiNik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kI99SR2iTTmxGnFDPlz8f3FwG8lelt3GDV0MRR7gFpFV+IFdPL9UnaPFzIBPu3pKQ1I0edA6qc1BlYg5U7JkLMGc+L7Q463WXen8r6dmZwGKNEAhqJ5Z4F0trNHFMRn0AiWlMItiaSqZg8d0arjJscc6tq0/5AarhlD91FFlVPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJAG5TPP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJAG5TPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA48C19425;
	Mon, 27 Apr 2026 23:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777333171;
	bh=Zl4RMPcd3Mruw3bjUpCvED7vUUWsDSlxRDKdrEHiNik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJAG5TPPkL4hNzaTsW+UlTD8dKhYf3YmFzUu3qYI4XfO6Eeb8u8f/9kam+xhjK4Gz
	 vwiZCBPy6dl/PL6NWYOnuMiHITcEJbJJA43QQscznMkdnL6P3D4eUDZaBl44Bj3D3/
	 khW/QfN9fKl455dtdmlROmX3g31VfX3+qo5H+n45e9QQEWK2tQM2XDeq0SUqUseMLq
	 io7ErQmwA2i/4QuFPcg6yJ3qyMxXTrDcnea/CNUb8bFN7IwQQuE5xW/o2qZq1ciE2G
	 x2CByJhldavvm69nIoAITyXdcYCeqhzAFQPXQ/3u1Dd+lRO6s75RUTr8yDAOW+xF2L
	 /eO/b4s2JFfPA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Cheng-Han Wu <hank20010209@gmail.com>,
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
	linux-mm@kvack.org
Subject: Re: [PATCH v2 2/4] Docs/admin-guide/mm/damon: fix 'parametrs' typo
Date: Mon, 27 Apr 2026 16:39:27 -0700
Message-ID: <20260427233927.146488-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426231619.107231-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 26 Apr 2026 16:16:15 -0700 SeongJae Park <sj@kernel.org> wrote:

> From: Cheng-Han Wu <hank20010209@gmail.com>
> 
> Fix the misspelling of "parametrs" as "parameters" in
> reclaim.rst and lru_sort.rst.
> 
> Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>

Oops, I forgot adding my Reviewed-by: tag.

Reviewed-by: SeongJae Park <sj@kernel.org>

Andrew, could you please add the above my Reviewed-by: tag?


Thanks,
SJ

[...]
