Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098107E
	for <damon@lists.linux.dev>; Mon,  4 Jul 2022 16:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EEAC3411E;
	Mon,  4 Jul 2022 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656953079;
	bh=Z2uRn29TAG3n10ZRXwiAj2SO+DVxbV7cjUpMOS7oyII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AAEg6VZH8BwyH6HOvW1qUdKSH2xNNEO0Bv1LzdjWzZ0vvIvzV9O+VsSD1laqJnpYo
	 1v6DYPyAhisFJvqFDIpeTraTd2KCL1ObYPyFNtQRgIP9KMSlW8buYT+eltzf+RJze0
	 i1XumXssUlrwjVgnF6IryDuAjk0UUBLNuumJGU0Ui548Uv9NoVW0OFCvgjmb5E/zN1
	 6mzay+evq4coOmWvLUQHegafS4wfWcgghtbF6cSOvzAXBzopa1hL8k0CnYd3SKBG51
	 a7lANjwEL5xfQr+vGb5WXHXdakGsKNAZ0+S6IfaMZRGsaH7+JpaAPrDQLfQsAWH+Qm
	 yyc2y5BA6JN1Q==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sjpark@amazon.de>,
	kbuild-all@lists.01.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 16/20] htmldocs: Documentation/PCI/index.rst: WARNING: document isn't included in any toctree
Date: Mon,  4 Jul 2022 16:44:37 +0000
Message-Id: <20220704164437.88314-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202207031427.IAzQ551Z-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 3 Jul 2022 14:36:56 +0800 kernel test robot <lkp@intel.com> wrote:
 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/=
> next
> head:   54aa71ecf6cac755c491a1992d83437cd2240311
> commit: 81b3079ea3e5ea85af358bb8a7621bb4f2aec50f [16/20] Docs: Modify for D=
> AMON only
> reproduce: make htmldocs
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):

Thank you for this reporting!  The warnings are due to a commit for DAMON
hacking tree that removes documents that not related with DAMON from the index
so that the document can be for only DAMON.  As the commit is only for DAMON
hacking tree and hence doesn't aim to be merged in the mainline or any other
trees, I will keep these warnings.


Thanks,
SJ

[...]
